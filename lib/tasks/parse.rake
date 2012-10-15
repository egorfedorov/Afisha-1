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
    html =   Nokogiri::HTML(open("http://www.redom.ru/afisha/week/cinema/"))
    #event =  html.css('table.playbill h2 a')
    event_list =  html.css('td.action')   #Список мероприятий


    event_list.each do |elem|
      event_url =  elem.parent.css('.action a').first['href']
      place_url =  elem.parent.css('.place a').first['href']


      event_entire =  Nokogiri::HTML(open(domen+event_url))     #Заходим в событие
      #event_entire =  Nokogiri::HTML(open('http://www.redom.ru/afisha/details/8865/'))     #Заходим в событие
         p  event_name = event_entire.css('h1.black').text
        ( p("Такой объект уже есть #{event_name}");  next )  if Item.find_by_title(event_name)    #выходим если итем уже есть
          cat =  Category.find_by_name('События')  || Category.create(:name=>'События', :type_id=>2)
        item = Item.new(:title =>event_name , :category_id =>cat.id  )
          cat_event = event_entire.css("td.action-reference small.genre").text

      cat_event.split(',').each do |cat|
        p("Категория не найдена - #{cat}") unless Category.find_by_name(cat.strip)
        item.category << Category.find_by_name(cat.strip)
      end




      desc = event_entire.at_css('div.action-description p').to_html(:encoding => 'UTF-8')
      info = event_entire.at_css('table.cells.reference').to_html(:encoding => 'UTF-8')

      item.full_text=desc
      item.info = info
      item.save!
      #################################
      gallery = Gallery.create(:item_id=> item.id, :name=>event_name)

      images = event_entire.css('td.action-picture div.trailers a img')
      images.each do |image|
          im = Image.new
          im.image =open image.parent['href']
          im.gallery = gallery
          im.save!
      end   if images

      image1 = event_entire.at_css('td.action-picture a')
      (im = Image.new
      im.image = open image1['href']
      im.gallery = gallery
      im.save! ) if image1

      #################################

      item.save!


       #event_entire.css('h6 span.red').each do |date|
       #
       #  p date.text
       #p date.next.text

       #end





      #
      #
      # p  "#{i} - #{t.text.gsub(', ' , '')}"



     #break

    end


    end


  task :photo_parse   =>:environment  do  |t , url ,item|

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