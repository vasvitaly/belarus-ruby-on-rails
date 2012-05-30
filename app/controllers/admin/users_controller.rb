class Admin::UsersController < ApplicationController
  load_and_authorize_resource :class => User

  def index
    store_location

    respond_to do |format|
      format.html { @users = User.filter(params[:filters])
        .paginate(:per_page => 10, :page => params[:page], :order => 'users.created_at DESC') }
      format.csv { export_csv(params[:filters]) }
    end
  end

  def update
    user = User.find(params[:id])
    case params[:attr]
      when 'admin'
        user.change_admin_state!
      when 'banned'
        user.change_banned_state!
    end

    redirect_to :action => :index
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_path, :notice => t('admin.users.delete_ok') }
      format.json { head :ok }
    end
  end

  protected

  def export_csv(filters)
    require 'iconv'
    filename = I18n.l(Time.now, :format => :short) + "- Users.csv"
    content = Iconv.conv("Windows-1251", "UTF-8//TRANSLIT", User.to_csv(User.filter(filters), filters))
    send_data content, :filename => filename
  end
end
