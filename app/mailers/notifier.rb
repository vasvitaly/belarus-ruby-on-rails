# -*- encoding : utf-8 -*-
class Notifier < ActionMailer::Base
  helper :application
  layout "email"
  default :from => "Белорусское сообщество Ruby On Rails <info@belarusrubyonrails.org>",
          :charset => "utf-8",
          :content_type => "text/html"

  def broadcast_message(to, subject, message)
    @email = to
    @message = message
    mail(:to => to, :subject => subject)
  end

  def comment(article)
    @article = article
    mail(:to => "info@belarusrubyonrails.org", :content_type => "text/plain")
  end

  def new_participant_for_meetup(meetup, participant)
    @email = participant.email
    @meetup = meetup
    mail :to => participant.email, :subject => @meetup.letter_subject
  end

  def new_participant_for_meetup_for_admin(meetup, participant)
    @participant = participant
    mail :to => "info@belarusrubyonrails.org", :subject => "#{meetup.topic} - новый участник мероприятия", :content_type => "text/plain"
  end

  def removed_participant_for_meetup_for_admin(meetup, participant)
    @meetup = meetup
    @participant = participant
    mail :to => "info@belarusrubyonrails.org", :subject => "#{@meetup.topic} - удален участник мероприятия", :content_type => "text/plain"
  end

  def accepted_participant_for_meetup(meetup, participant)
    @email = participant.email
    @meetup = meetup
    mail :to => participant.email, :subject => "#{@meetup.topic} - одобрено участие"
  end

  def declined_participant_for_meetup(meetup, participant)
    @email = participant.email
    @meetup = meetup
    mail :to => participant.email, :subject => "#{@meetup.topic} - отклонено участие"
  end

  def user_unsubscribed(user)
    @user = user
    mail :to => "info@belarusrubyonrails.org", :subject => "Пользователь отписался от рассылок", :content_type => "text/plain"
  end
end
