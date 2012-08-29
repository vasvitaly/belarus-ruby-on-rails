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
                  '<p>Белорусская Java User Group распложена в Минске и призвана объединить Java-программистов, пользователей Java и IT-компании в Беларуси, работающие с Java. Мы ориентируемся на регулярные встречи и обмен опытом, рекомендациями и идеями о том, как наилучшим образом использовать Java-технологии в нашей ежедневной работе. Мы также пытаемся помочь нашим участникам найти работу на Java в Беларуси и за её пределами.</p><p>В данный момент координатором сообщества Java-разработчиков является Алексей Хижняк. Если вы хотите связаться с ним или другими организаторами, пишите на <a href="mailto:chair@belarusjug.org">chair@belarusjug.org</a></p>'
                else
                  '<p>Белорусская Java User Group распложена в Минске и призвана объединить Java-программистов, пользователей Java и IT-компании в Беларуси, работающие с Java. Мы ориентируемся на регулярные встречи и обмен опытом, рекомендациями и идеями о том, как наилучшим образом использовать Java-технологии в нашей ежедневной работе. Мы также пытаемся помочь нашим участникам найти работу на Java в Беларуси и за её пределами.</p><p>В данный момент координатором сообщества Java-разработчиков является Алексей Хижняк. Если вы хотите связаться с ним или другими организаторами, пишите на <a href="mailto:chair@belarusjug.org">chair@belarusjug.org</a></p>'
                end

title_about = if I18n.locale.to_s == 'ru'
                'О нас'
              else
                'About'
              end

content_friends = '<p><a href="http://jug.com.ua/" rel="nofollow" target="_blank">Сайт украинской группы Java разработчиков</a></p><p><a href="http://jug.org.ua/" rel="nofollow" target="_blank">Java developers community of KPI</a></p><p><a href="http://www.jug.ru" rel="nofollow" target="_blank">JUG.RU</a></p><p><a href="http://jug.vrn.ru/" rel="nofollow" target="_blank">Java User Group Voronezh</a></p><p><a href="http://www.bafpug.com" rel="nofollow" target="_blank">Belarusian Adobe Flash Platform User Group</a></p><p><a href="http://oslab.by/" rel="nofollow" target="_blank">Belarus Open Source Lab</a></p>'

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
