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
           ['Что такое Java?', 'Новичок', 'Средний', 'Эксперт']
         else
           ['What is Java?', 'Beginner', 'Intermediate', 'Expert']
         end
Experience.delete_all
levels.each do |level|
  Experience.create(:level => level)
end

twitter_block_settings = if I18n.locale.to_s == 'ru'
                          {:title => 'Что пишут о',
                          :subject => 'Belarus Java',
                          :footer_text => 'Присоединиться к обсуждению'}
                        else
                          {:title => 'What is written about',
                          :subject => 'Belarus Java',
                          :footer_text => 'Join the conversation'}
                        end
TwitterBlock.delete_all
TwitterBlock.create(
  :title => twitter_block_settings[:title],
  :subject => twitter_block_settings[:subject],
  :search => '#hacby',
  :footer_text => twitter_block_settings[:footer_text]
)

StaticPage.delete_all
content_about = if I18n.locale.to_s == 'ru'
                  '<p>Белорусская Java User Group - сообщество Rails-девелоперов в Беларуси, созданное для обмена идеями и опытом. Мы также заинтересованы в развитии Java в нашей стране и помогаем друг другу построить успешную IT-карьеру.</p><p>Если Вы тоже желаете участвовать в развитии Belarus Java User Group, присылайте свои идеи на адрес:</p><p><a href="mailto:info@belarusjug.org">info@belarusjug.org</a></p>'
                else
                  '<p>Belarussian Java User Group is community of Rails-developers in Belarus, was found for exchenging ideas and expirience. We are also interested in developing Java in our country and help each other to build successfull IT-career.</p><p>If you would like take part in developing Belarus Java User Group, please send your ideas to: <a href="mailto:info@belarusjug.org">info@belarusjug.org</a></p>'
                end

title_about = if I18n.locale.to_s == 'ru'
                'О нас'
              else
                'About'
              end

content_friends = '<p><a target="_blank" href="http://belarusrubyonrails.org/">Belarus Ruby on Rails User Group</a></p><p><a rel="nofollow" target="_blank" href="http://belarusflex.org">Belarus Flex User Group</a></p>'

title_friends = if I18n.locale.to_s == 'ru'
                'Друзья'
              else
                'Friends'
              end
StaticPage.create(:title => title_about, :permalink => 'about', :content => content_about)
StaticPage.create(:title => title_friends, :permalink => 'friends', :content => content_friends)

AggregatorConfiguration.create(
  :source => 'http://news.google.com/news?pz=1&cf=all&ned=ru_ru&hl=ru&q=%22java%22+OR+%22%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5+%D0%BD%D0%B0+java%22+OR+%22java+user+group%22+OR+%22%D1%81%D0%BE%D0%BE%D0%B1%D1%89%D0%B5%D1%81%D1%82%D0%B2%D0%BE+java+%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%81%D1%82%D0%BE%D0%B2%22+OR+%22Spring+Framework%22+OR+%22Hibernate%22+OR+%22iBatis%22+OR+%22JSF%22+OR+%22tapestry%22+OR+%22struts%22+OR+%22j2ee%22+OR+%22j2se%22+OR+%22j2me%22+OR+%22javafx%22&as_qdr=d&as_drrb=q&cf=all&scoring=n&output=rss'
)
