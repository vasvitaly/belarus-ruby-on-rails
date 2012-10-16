# -*- encoding : utf-8 -*-
module RSS
  extend self

  def fetch_aggregators
    print "fetch_aggregators started\n"
    AggregatorConfiguration.find_each do |config|
      print "using #{config.source}\n"
      next if config.source.blank?
      feed_object = Feedzirra::Feed.fetch_and_parse(config.source)
      new_entries = feed_object.entries
      new_entries.each do |entry|
        print "found entry: #{entry.title}\n"

        #check article date
        next if (Time.now.utc.to_date - entry.published.to_date).to_i != 0
        next unless entry.url
        rss_link = entry.url
        complex_rss_link = rss_link.scan(/&url=(.*?)$/)
        if complex_rss_link && complex_rss_link.count > 0
          rss_link = complex_rss_link[0][0]
        end
        title = entry.title.gsub(%r{</?[^>]+?>}, '')
        content = (entry.summary || entry.content)
                  .gsub(%r{</?[^>]+?>}, '')
                  .gsub('и другие&nbsp;&raquo;', '')
                  .gsub('читать дальше', '')

        #check similarity
        white = Text::WhiteSimilarity.new
        $similarity = 0
        published = entry.published.strftime("%Y-%m-%d")
        AggregatedArticle.where("created_at >= ('#{published}' - INTERVAL 1 WEEK) AND created_at <= ('#{published}' + INTERVAL 1 WEEK)").each do |article|
          $similarity = [white.similarity(title, article.title), white.similarity(content, article.content)].max
          if $similarity >= 0.7
            print "found similarity: #{$similarity}\n"
            break
          end
        end
        next if $similarity >= 0.7

        #create article
        AggregatedArticle.create(:title      => title,
                                 :content    => content,
                                 :rss_link   => rss_link,
                                 :published  => true,
                                 :created_at => entry.published)
        print "saved entry: #{entry.title}\n"
      end
      config.update_attributes(:feed_object => feed_object)
    end
    print "fetch_aggregators finished\n"
  end
end
