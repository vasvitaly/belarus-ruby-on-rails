# -*- encoding : utf-8 -*-
class Notifier < ActionMailer::Base
  helper :application
  layout "email"
  default :from => SITE_CONFIG['notifier']['default']['from'],
          :charset => "utf-8",
          :content_type => "text/html"

  def broadcast_message(to, subject, message)
    @email = to
    @message = message
    mail(:to => to, :subject => subject)
  end

  def comment(article, user)
    @article = article
    mail(:to => user.email, :content_type => "text/plain")
  end

  def new_participant_for_meetup(meetup, participant)
    @email = participant.email
    @meetup = meetup
    mail :to => participant.email, :subject => @meetup.letter_subject
  end

  def new_participant_for_meetup_for_admin(meetup, participant)
    @participant = participant
    mail :to => SITE_CONFIG['notifier']['default']['to'], :subject => "#{meetup.topic} - новый участник мероприятия", :content_type => "text/plain"
  end

  def removed_participant_for_meetup_for_admin(meetup, participant)
    @meetup = meetup
    @participant = participant
    mail :to => SITE_CONFIG['notifier']['default']['to'], :subject => "#{@meetup.topic} - удален участник мероприятия", :content_type => "text/plain"
  end

  def accepted_participant_for_meetup(meetup, participant)
    @email = participant.email
    @meetup = meetup
    subject = @meetup.accept_email_subject.blank? ? "одобрено участие" : @meetup.accept_email_subject
    mail :to => participant.email, :subject => "#{@meetup.topic} - #{subject}"
  end

  def declined_participant_for_meetup(meetup, participant)
    @email = participant.email
    @meetup = meetup
    subject = @meetup.decline_email_subject.blank? ? "отклонено участие" : @meetup.decline_email_subject
    mail :to => participant.email, :subject => "#{@meetup.topic} - #{subject}"
  end

  def user_unsubscribed(user)
    @user = user
    mail :to => SITE_CONFIG['notifier']['default']['to'], :subject => "Пользователь отписался от рассылок", :content_type => "text/plain"
  end
end
