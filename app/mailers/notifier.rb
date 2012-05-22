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
    mail :to => participant.email, :subject => t('subject_for_new_participant_message')
  end
end
