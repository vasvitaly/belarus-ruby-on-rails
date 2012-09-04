# -*- encoding : utf-8 -*-
class ParticipantsController < ApplicationController
  load_and_authorize_resource

  before_filter :find_meetup

  def new
    @participant = Participant.new
    @meetup.questions.each do |q|
      @participant.quizzes.new(:question => q)
    end
  end

  def create
    @participant = Participant.new((params[:participant] || {}).merge(:user => current_user, :meetup => @meetup))
    if @participant.save
      @participant.user.index!
      Notifier.new_participant_for_meetup(@meetup, @participant).deliver
      Notifier.new_participant_for_meetup_for_admin(@meetup, @participant).deliver
      redirect_to meetup_registration_thanks_path(@meetup.id), :notice => t('meetup.successfully_registered')
    else
      flash[:error] = t("meetup.registration_form_incorrect")
      render :new
    end
  end

  def destroy
    as_admin = current_user.is_admin && params[:user_id] && params[:filters]
    if as_admin
      user = User.find(params[:user_id])
      @participants = user.participants.participants_on(params[:filters])
    else
      user = User.find(current_user.id)
      @participants = user.participants.participants_on(@meetup.id)
      (@filters || [@meetup]).each do |meetup|
        Notifier.removed_participant_for_meetup_for_admin(meetup, current_user).deliver
      end
    end
    @participants.destroy_all
    user.index!

    respond_to do |format|
      format.html { redirect_to as_admin ? admin_users_path : root_path, :notice => t('admin.participants.participant_successfully_deleted') }
      format.js
      format.json { head :ok }
    end
  end

  def accept
    if current_user.is_admin && params[:user_id] && params[:filters]
      user = User.find(params[:user_id])
      @participants = user.participants.participants_on(params[:filters])
      @filters.each do |meetup|
        Notifier.accepted_participant_for_meetup(meetup, user).deliver
      end
    end
    @participants.update_all({:accepted => true})
    user.index!

    respond_to do |format|
      format.html { redirect_to admin_users_path, :notice => t('admin.participants.participant_successfully_accepted') }
      format.js
      format.json { head :ok }
    end
  end

  def decline
    if current_user.is_admin && params[:user_id] && params[:filters]
      user = User.find(params[:user_id])
      @participants = user.participants.participants_on(params[:filters])
      @filters.each do |meetup|
        Notifier.declined_participant_for_meetup(meetup, user).deliver
      end
    end
    @participants.update_all({:accepted => false})
    user.index!

    respond_to do |format|
      format.html { redirect_to admin_users_path, :notice => t('admin.participants.participant_successfully_declined') }
      format.js
      format.json { head :ok }
    end
  end

  def find_meetup
    @meetup = Meetup.find(params[:meetup_id]) if params[:meetup_id].to_i > 0
    @filters = Meetup.find(params[:filters]) unless params[:filters].blank?
  end
end
