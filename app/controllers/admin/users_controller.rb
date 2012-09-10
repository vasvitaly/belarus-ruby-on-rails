require 'writeexcel'
require 'stringio'

class Admin::UsersController < ApplicationController
  load_and_authorize_resource :class => User

  def index
    store_location

    @users = User.search do
      fulltext params[:search][:query] unless params.try(:[], :search).try(:[], :query).blank?
      with :meetup_id, params[:filters] unless params[:filters].blank?
      unless params.try(:[], :search).try(:[], :accepted).blank? || params[:filters].blank?
        with :accepted, params[:filters].map{|meetup_id| "#{meetup_id}_#{params[:search][:accepted]}"}
      end
      unless params.try(:[], :search).try(:[], :date).try(:[], :start).blank? || params.try(:[], :search).try(:[], :date).try(:[], :end).blank?
        with :created_at, params[:search][:date][:start]..params[:search][:date][:end]
        with :created_participant_at, params[:search][:date][:start]..params[:search][:date][:end]
      end
      order_by params[:filters].blank? ? :created_at : :created_last_participant_at, :desc
      if params[:format].nil?
        paginate :per_page => 10, :page => params[:page]
      else
        paginate :per_page => 1000
      end
    end
    .results

    respond_to do |format|
      format.html
      format.xls {
        io = StringIO.new
        workbook = WriteExcel.new(io)
        worksheet  = workbook.add_worksheet
        questions = Question.where(:meetup_id => params[:filters])

        headers = [
          I18n.t('admin.users.number'),
          I18n.t('activerecord.attributes.profile.first_name'),
          I18n.t('activerecord.attributes.profile.last_name'),
          I18n.t('activerecord.attributes.user.email'),
          I18n.t('activerecord.attributes.experience.level'),
          I18n.t('activerecord.attributes.user.created_at'),
        ]
        headers += Meetup.find(params[:filters]).collect(&:topic)
        headers += questions.collect(&:gist)
        headers.each_with_index do |header, i|
          worksheet.write(0, i, header)
        end

        question_ids = questions.collect(&:id)
        @users.each_with_index do |user, i|
          cells = [
            i + 1,
            user.profile.first_name,
            user.profile.last_name,
            user.email,
            user.profile.experience.level,
            user.created_at,
          ]
          cells += params[:filters].map do |meetup_id|
            Participant.where(:meetup_id => meetup_id, :user_id => user.id).first.try(:accepted).to_s
          end
          cells += question_ids.map do |question_id|
            Array.wrap(Quiz.where(:participant_id => user.participants.collect(&:id), :question_id => question_id).first.try(:answer)).join("; ")
          end
          cells.each_with_index do |cell, j|
            worksheet.write(i+1, j, cell)
          end
        end

        workbook.close
        filename = I18n.l(Time.now, :format => :short) + "- Users.xls"
        content = io.string
        send_data content, :filename => filename
      }
    end
  end

  def update
    user = User.find(params[:id])
    case params[:attr]
      when 'admin'
        user.change_admin_state!
      when 'banned'
        user.change_banned_state!
    end

    redirect_to :action => :index
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_path, :notice => t('admin.users.delete_ok') }
      format.json { head :ok }
    end
  end

end
