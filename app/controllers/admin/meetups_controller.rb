class Admin::MeetupsController < ApplicationController
  load_and_authorize_resource :class => Meetup

  def new
    @meetup = Meetup.new
  end

  def create
    @meetup = Meetup.new(params[:meetup])

    if @meetup.save
      flash[:notice] = t('meetup.create_ok')
      redirect_to admin_meetups_url
    else
      respond_to do |format|
        format.html {
          flash[:notice] = @meetup.errors.full_messages.join("\n")
          render :action => "new"
        }
        format.json { head :ok }
      end
    end
  end

  def index
    @meetup = Meetup.active.recent.first
    @events = Meetup.paginate(:per_page => 10, :page => params[:page], :order => 'meetups.date_and_time DESC')
  end

  def cancel
    @meetup = Meetup.find(params[:meetup_id])
    @meetup.update_attribute(:cancelled, true)

    flash[:notice] = t('meetup.cancel_ok')
    redirect_to admin_meetups_path
  end

  def update
    @meetup = Meetup.find(params[:id])

    if @meetup.update_attributes(params[:meetup])
      flash[:notice] = t('meetup.update_ok')
      redirect_to admin_meetups_path
    else
      respond_to do |format|
        format.html {
          flash[:notice] = @meetup.errors.full_messages.join("\n")
          render :action => "edit"
        }
        format.json { render :json => @meetup.errors }
      end
    end
  end

  def destroy
    @meetup = Meetup.find(params[:id])
    @meetup.destroy

    respond_to do |format|
      format.html { redirect_to admin_meetups_path, :notice => t('meetup.delete_ok') }
      format.json { head :ok }
    end
  end

  def tryout_message
    @meetup = Meetup.new(params[:meetup])
    @participant = Participant.new(:user => current_user, :meetup => @meetup)
    Notifier.new_participant_for_meetup(@meetup, @participant).deliver
    respond_to do |format|
      format.js { render :template => "shared/tryout_message" }
    end
  end
end
