# -*- encoding : utf-8 -*-
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Белорусское сообщество PaaS"
    xml.description "Новости сообщества Ruby On Rails в Беларуси"
    xml.link articles_url

    @articles.each do |post|
      xml.item do
        xml.title post.title
        xml.description post.content
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link article_url(post)
        xml.guid article_url(post)
      end
    end
  end
end
