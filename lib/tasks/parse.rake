#coding=utf-8
namespace :parser  do
  desc "Parse категорий событий "
  task :category_parse  =>:environment  do  |t , arg|
    domen = 'http://www.redom.ru'
    html =   Nokogiri::HTML(open("http://www.redom.ru/afisha/details/8876/"))
    table =  html.css('table.catlist')
    table =table.css('a')

    table.each do |elem|
      p elem.text + ' --' + elem['href']
      parent_cat = Category.find_by_name(elem.text) ||  Category.create(:name => elem.text , :type_id=>1)
          p parent_cat
        sub_cats = Nokogiri::HTML(open(domen+elem['href']))

           sub_cats.at_css('td.genres-container').css('a').each do |sub_cat|
             p '----'+sub_cat.text
            sub_cat = Category.find_by_name(sub_cat.text) || Category.create(:name => sub_cat.text ,
                                                                          :parent_id =>parent_cat.id,
                                                                          :type_id=>1)
             p sub_cat

           end   if   sub_cats.at_css('td.genres-container')

    end
  end

    desc "Parse  событий "
    task :event_parse  =>:environment  do  |t , arg|

      item_count = 0
    domen = 'http://www.redom.ru'
    html =   Nokogiri::HTML(open("http://www.redom.ru/afisha/month/theater/"))
    #event =  html.css('table.playbill h2 a')
    event_list =  html.css('td.action')   #Список мероприятий


    event_list.each do |elem|
      event_url =  elem.parent.css('.action a').first['href']
      place_url =  elem.parent.css('.place a').first['href']


      event_entire =  Nokogiri::HTML(open(domen+event_url))     #Заходим в событие
         p  event_name = event_entire.css('h1.black').text
           break  if Item.find_by_title(event_name)
          cat =  Category.find_by_name('События')  || Category.create(:name=>'События', :type_id=>2)
        item = Item.new(:title =>event_name , :category_id =>cat.id  )
          cat_event = event_entire.css("small.genre").text
       break unless cat = Category.find_by_name(cat_event)

      item.category=cat

      desc = event_entire.at_css('div.action-description p').to_html(:encoding => 'UTF-8')
      info = event_entire.at_css('table.cells.reference').to_html(:encoding => 'UTF-8')

      item.full_text=desc
      item.info = info

      if ( item.save! )
          item_count += 1
      end

      date = event_entire.css('h6 span.red').text
      #
      #
      # p  "#{i} - #{t.text.gsub(', ' , '')}"



     break

    end

      #Rake::Task['parser:r'].invoke
    end


  task :photo_parse  =>:environment  do  |t , url ,item|

    gallery = Gallery.create(:item=> item)
    html =   Nokogiri::HTML(open(url))
    images = html.css('td.action-picture div.trailers a')
    images.each do |image|
      Image.create(:image => image['href']  , :gallery => gallery)

    end
    image1 = html.css('td.action-picture a')

    Image.create(:image => image1.first['href']  , :gallery => gallery)

  end

end