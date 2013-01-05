class Admin::MessagesController < ApplicationController
  load_and_authorize_resource

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])

    if @message.valid?
      Message.deliver(@message.recipient_group, @message.subject, @message.body, @message.reversed, @message.accepted)
      redirect_to admin_root_url, :notice => I18n.t('admin.messages.successfully_sent')
    else
      render :action => 'new'
    end
  end

  def tryout_message
    @message = Message.new(params[:message])
    @participant = Participant.new(:user => current_user)
    Notifier.broadcast_message(current_user.email, @message.subject, @message.body).deliver
    respond_to do |format|
      format.js { render :template => "shared/tryout_message" }
    end
  end
end
