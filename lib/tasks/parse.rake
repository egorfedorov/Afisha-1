#coding=utf-8
namespace :parser  do
  desc "Parse категорий событий "
  task :category_parse  =>:environment  do  |t , arg|

    html =   Nokogiri::HTML(open("http://www.redom.ru/afisha/details/8876/"))
    table =  html.css('table.catlist')
    table =table.css('a')
    table.each do |elem|
      #Category.create(:name=>elem.text , :type_id=>1)
      p elem.text
    end
  end

    desc "Parse  событий "
    task :event_parse  =>:environment  do  |t , arg|
     # domen = 'http://www.redom.ru'
     # html =   Nokogiri::HTML(open("http://www.redom.ru/afisha/month/theater/"))
     # #event =  html.css('table.playbill h2 a')
     # block1 =  html.css('td.action')
     #
     # #p event.first.text
     # block1.each do |elem|
     #event =  elem.parent.css('.action a')
     # place =  elem.parent.css('.place a')
     # time  =  elem.parent.css('.seance b')
     #
     # event_entire =  Nokogiri::HTML(open(domen+event.first['href']))
     #date = event_entire.css('h6 span.red').text
     # #date  =  elem.parent.parent.parent.previous.css('.red').text
     # i = 1
     # time.each do |t|
     #  p  "#{i} - #{t.text.gsub(', ' , '')}"
     #   i +=1
     # end
     #
     # p  event.text+ '--'+place.text + ' - '+ '--'+date
     # break
     #   #Category.create(:name=>elem.text , :type_id=>1)
     #  end

      url = 'http://www.redom.ru/afisha/details/8142/'
      html =   Nokogiri::HTML(open(url))
      images = html.css('td.action-picture div.trailers a')
      images.each do |image|
        p image['href']

      end
      image1 = html.css('td.action-picture a')
        p image1.first['href']

    end




end