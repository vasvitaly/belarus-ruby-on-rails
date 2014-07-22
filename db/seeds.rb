# encoding: UTF-8
#
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

levels = if I18n.locale.to_s == 'ru'
           ['Что такое PaaS?', 'Новичок', 'Средний', 'Эксперт']
         else
           ['What is PaaS?', 'Beginner', 'Intermediate', 'Expert']
         end
Experience.delete_all
levels.each do |level|
  Experience.create(:level => level)
end

twitter_block_settings = if I18n.locale.to_s == 'ru'
                          {:title => 'Что пишут о',
                          :subject => 'Belarus PaaS',
                          :footer_text => 'Присоединиться к обсуждению'}
                        else
                          {:title => 'What is written about',
                          :subject => 'Belarus PaaS',
                          :footer_text => 'Join the conversation'}
                        end
TwitterBlock.delete_all
TwitterBlock.create(
  :title => twitter_block_settings[:title],
  :subject => twitter_block_settings[:subject],
  :search => '#paas',
  :footer_text => twitter_block_settings[:footer_text]
)

StaticPage.delete_all
content_about = if I18n.locale.to_s == 'ru'
                  '<p>Белорусская PaaS User Group - сообщество PaaS-девелоперов в Беларуси, созданное для обмена идеями и опытом. Мы также заинтересованы в развитии PaaS в нашей стране и помогаем друг другу построить успешную IT-карьеру.</p><p>Если Вы тоже желаете участвовать в развитии Belarus PaaS User Group, присылайте свои идеи на адрес:</p><p><a href="mailto:info@paaspro.by">info@paaspro.by</a></p>'
                else
                  '<p>Belarussian PaaS User Group is community of PaaS-developers in Belarus, was found for exchenging ideas and expirience. We are also interested in developing PaaS in our country and help each other to build successfull IT-career.</p><p>If you would like take part in developing Belarus PaaS User Group, please send your ideas to: <a href="mailto:info@paaspro.by">info@paaspro.by</a></p>'
                end

title_about = if I18n.locale.to_s == 'ru'
                'О нас'
              else
                'About'
              end

content_friends = '<p><a target="_blank" href="http://belarusjug.org/">Belarus Java User Group</a></p><p><a rel="nofollow" target="_blank" href="http://belarusflex.org">Belarus Flex User Group</a></p>'

title_friends = if I18n.locale.to_s == 'ru'
                'Друзья'
              else
                'Friends'
              end
StaticPage.create(:title => title_about, :permalink => 'about', :content => content_about)
StaticPage.create(:title => title_friends, :permalink => 'friends', :content => content_friends)

AggregatorConfiguration.create(
  :source => 'http://news.google.com/news?cf=all&ned=ru_ru&hl=ru&q=paas&as_qdr=d&as_drrb=q&cf=all&scoring=n&output=rss'
)
