class Admin::MessagesController < ApplicationController
  load_and_authorize_resource

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])

    if @message.valid?
      recipients = if @message.reversed == "yes"
        if @message.recipient_group
          Profile.subscribed.includes(:user).uniq - Profile.subscribed.filter(@message.recipient_group).includes(:user).uniq
        else
          Profile.subscribed.includes(:user).uniq
        end
      else
        Profile.subscribed.filter(@message.recipient_group).includes(:user).uniq
      end
      recipients.each do |recipient|
        #Notifier.delay.broadcast_message(recipient.user.email, @message.subject, @message.body)
        Notifier.broadcast_message(recipient.user.email, @message.subject, @message.body).deliver
      end
      redirect_to admin_root_url, :notice => I18n.t('admin.messages.successfully_sent')
    else
      render :action => 'new'
    end
  end
end
