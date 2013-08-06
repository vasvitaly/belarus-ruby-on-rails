class Admin::VideosController < ApplicationController
  load_and_authorize_resource

  def index
    authorize! :admin, :dashboard
    @videos = Video.paginate(
      :per_page => 20,
      :page => params[:page],
      :order => 'created_at DESC'
    )
  end

  def fetch
  	client = YouTubeIt::Client.new(:dev_key => SOCIAL_CONFIG['youtube']['dev_key'])
  	@videos = client.videos_by(:user => SOCIAL_CONFIG['youtube']['username']).videos.paginate(
      :per_page => 5,
      :page => params[:page]
    )
  end
end