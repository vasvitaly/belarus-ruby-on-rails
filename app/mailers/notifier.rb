class Notifier < ActionMailer::Base
  default :from => "no-reply@belarusrubyonrails.org", :charset => 'utf-8'

  def custom(to, subject, body)
    mail(:to => to, :subject => subject, :body => body)
  end

  def comment(to, article)
    @article = article
    mail(:to => to)
  end
end
