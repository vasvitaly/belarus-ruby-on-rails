class Admin::UsersController < ApplicationController
  load_and_authorize_resource :class => User

  def index
    store_location

    respond_to do |format|
      format.html {
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
          paginate :per_page => 10, :page => params[:page]
        end
        .results
      }
      format.csv { export_csv(params[:filters]) }
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

  protected

  def export_csv(filters)
    require 'iconv'
    filename = I18n.l(Time.now, :format => :short) + "- Users.csv"
    content = Iconv.conv("Windows-1251", "UTF-8//TRANSLIT", User.to_csv(User.filter(filters), filters))
    send_data content, :filename => filename
  end
end
