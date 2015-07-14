class Video < ActiveRecord::Base
  attr_accessible :title, :description, :content, :published_at
  validates_presence_of :title, :published_at, :content

  before_save :digest_content

  def digest_content
    if self.content =~ /src="([^"]+)"/
      url = $1
      url_with_http = url.include?('http') ? url : "http:#{url}"
      self.content = url_with_http
    end
  end


  class << self
    def screening(fetched_videos)
      videos = []
      contents = pluck :content

      fetched_videos.each do |video|
        html = video['player']['embedHtml']
        url_with_http = nil
        if html =~ /src="([^"]+)"/
          url = $1
          url_with_http = url.include?('http:') ? url : "http:#{url}"
          unless contents.include?(url_with_http)
            videos.push(digest_video(video, url)) 
          end
        end
      end
      videos
    end

    def digest_video(video, url)
      if video['snippet'].present?
        video['title'] = video['snippet']['title']
        video['description'] = video['snippet']['description']
        video['published_at'] = video['snippet']['publishedAt'].present? ? DateTime.parse(video['snippet']['publishedAt']) : Time.now
      end
      video['url'] = url
      video
    end

    def add_videos(fetched_videos_params)
      fetched_videos_params.each { |params| Video.create(eval(params)) }
    end
  end
end
