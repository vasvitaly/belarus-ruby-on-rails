# -*- encoding : utf-8 -*-
class ParticipantsController < ApplicationController
  load_and_authorize_resource

  def new
    @participant = Participant.new
    @meetup.questions.each do |q|
      @participant.quizzes.new(:question => q)
    end
  end

  def create
    @participant = Participant.new((params[:participant] || {}).merge(:user => current_user, :meetup => @meetup))
    if @participant.save
      Notifier.new_participant_for_meetup(@meetup, @participant).deliver
      Notifier.new_participant_for_meetup_for_admin(@meetup, @participant).deliver
      redirect_to meetup_registration_thanks_path, :notice => t('meetup.successfully_registered')
    else
      flash[:error] = t("meetup.registration_form_incorrect")
      render :new
    end
  end

  def destroy
    as_admin = current_user.is_admin && params[:user_id] && params[:filters]
    if as_admin
      @participants = User.find(params[:user_id]).participants.participants_on(params[:filters])
    else
      @participants = User.find(current_user.id).participants.participants_on(@meetup.id)
      Notifier.removed_participant_for_meetup_for_admin(@meetup, current_user).deliver
    end
    @participants.destroy_all

    respond_to do |format|
      format.html { redirect_to as_admin ? admin_users_path : root_path, :notice => t('admin.participants.participant_successfully_deleted') }
      format.json { head :ok }
    end
  end
end
