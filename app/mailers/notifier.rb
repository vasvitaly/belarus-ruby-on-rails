# -*- encoding : utf-8 -*-
class Notifier < ActionMailer::Base
  default :from => "no-reply@belarusrubyonrails.org", :charset => 'utf-8'

  def custom(to, subject, body)
    mail(:to => to, :subject => subject, :body => body)
  end

  def comment(to, article)
    @article = article
    mail(:to => to)
  end

  def new_participant_for_meetup(meetup, participant)
    @meetup = meetup
    mail :to => participant.email, :subject => @meetup.letter_subject, :body => @meetup.letter_body
  end

  def new_participant_for_meetup_for_admin(meetup, participant)
    @meetup = meetup
    mail :to => "info@belarusrubyonrails.org", :subject => "#{@meetup.topic} - новый участник мероприятия",
      :body => "ID участника: #{participant.id}, email: #{participant.email}"
  end
end
