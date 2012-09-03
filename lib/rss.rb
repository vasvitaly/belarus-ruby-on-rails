# -*- encoding : utf-8 -*-
module RSS
  extend self

  def fetch_aggregators
    AggregatorConfiguration.find_each do |config|
      next if config.source.blank?
      feed_object = config.feed_object
      if feed_object && feed_object.feed_url == config.source
        feed_object = Feedzirra::Feed.update(feed_object)
        next if !feed_object.has_new_entries?
        new_entries = feed_object.new_entries
      else
        feed_object = Feedzirra::Feed.fetch_and_parse(config.source)
        new_entries = feed_object.entries
      end
      new_entries.each do |entry|
        next if (Date.today - entry.published.to_date).to_i != 0
        next unless entry.url
        rss_link = entry.url
        complex_rss_link = rss_link.scan(/&url=(.*?)$/)
        if complex_rss_link && complex_rss_link.count > 0
          rss_link = complex_rss_link[0][0]
        end
        AggregatedArticle.create(:title      => entry.title.gsub(%r{</?[^>]+?>}, ''),
                                 :content    => entry.summary.gsub(%r{</?[^>]+?>}, '').gsub('и другие&nbsp;&raquo;', ''),
                                 :rss_link   => rss_link,
                                 :published  => true,
                                 :created_at => entry.published)
      end
      config.update_attributes(:feed_object => feed_object)
    end
  end
end
