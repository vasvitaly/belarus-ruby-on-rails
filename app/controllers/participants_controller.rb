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
    @participant = Participant.new(params[:participant].merge(:user => current_user, :meetup => @meetup))
    if @participant.save
      redirect_to root_path, :notice => 'Вы зарегистрировались мероприятие успешно'
    else
      flash[:error] = 'Форма содержит ошибки'
      render :new
    end
  end
end
