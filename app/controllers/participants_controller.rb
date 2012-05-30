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
    @participants = User.find(params[:user_id]).participants.participants_on(params[:filters])
    @participants.destroy_all

    respond_to do |format|
      format.html { redirect_to admin_users_path, :notice => t('admin.participants.participant_successfully_deleted') }
      format.json { head :ok }
    end
  end
end
