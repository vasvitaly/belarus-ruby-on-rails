class Admin::VideosController < ApplicationController
  load_and_authorize_resource
  before_filter :find_video, :only => [:destroy, :update]

  def index
    authorize! :admin, :dashboard
    @videos = Video.paginate(
      :per_page => 20,
      :page => params[:page],
      :order => 'created_at DESC'
    )
  end

  def fetch
    # client = YouTubeIt::Client.new(:dev_key => SOCIAL_CONFIG['youtube']['dev_key'])
    # fetched_videos = client.videos_by(:user => SOCIAL_CONFIG['youtube']['username']).videos
    options = { developer_key: SOCIAL_CONFIG['youtube']['dev_key'],
      application_name: 'AltorosSystemsYT',
      application_version: 2.0,
      log_level: 3 
    }
    client = Yourub::Client.new(options)
    fetched_videos = []
    fields = 'items(id,snippet(title,thumbnails,description,publishedAt),player(embedHtml))'
    part = 'snippet,player'
    client.search({query: SOCIAL_CONFIG['youtube']['username']}, part, fields) do |v|
      fetched_videos << v
    end

    @videos = Video.screening(fetched_videos).paginate(
      :per_page => 10,
      :page => params[:page]
    )
  end

  def new
    @video = Video.new
  end

  def create
    Video.add_videos(params[:fetched_videos]) if params[:fetched_videos]
    Video.create(params[:video]) if params[:video]

    redirect_to admin_videos_path
  end

  def destroy
    @video.destroy
    redirect_to admin_videos_path
  end

  def update
    @video.update_attributes(params[:video])
    redirect_to admin_videos_path
  end

  private
  def find_video
   @video = Video.find(params[:id])
  end
end
