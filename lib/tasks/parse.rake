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
###############################################################
  #TODO refactor me

    desc "Parse  событий "
    task :item_parse  =>:environment  do  |t , arg|
    #require  "ParseHelper"
    include  ParseHelper
      item_count = 0
    domen = 'http://www.redom.ru'
    html =   Nokogiri::HTML(open("http://www.redom.ru/afisha/week/cinema/"))
    #event =  html.css('table.playbill h2 a')

      parent_cat = html.xpath("//table[@class='catlist']/tr/td/span").text

      event_list =  html.css('td.action')   #Список мероприятий


    event_list.each do |elem|
      event_url =  elem.css('h2 a').first['href']
      #place_url =  elem.parent.css('.place a').first['href']

         next  if Item.find_by_title(elem.parent.css('.action a').first.text) # Пропускаем если уже есть такой item

        event_entire =  Nokogiri::HTML(open(domen+event_url))     #Заходим в событие
        #event_entire =  Nokogiri::HTML(open("http://www.redom.ru/afisha/details/8866/"))     #Заходим в событие

         p  event_name = event_entire.css('h1.black').text

         item = Item.new(:title =>event_name)

        cat_event = event_entire.css("td.action-reference small.genre").text

        cat_event.split(',').each do |cat|
          #p("Категория не найдена - #{cat}") unless Category.find_by_name(cat.strip)
           Category.create(:name=>cat.strip ,:parent_id=>Category.find_by_name(parent_cat).id,:type_id=>1)    unless Category.find_by_name(cat.strip)
          item.category << Category.find_by_name(cat.strip)

        end

      item.category << Category.find_by_name(parent_cat) if  cat_event.empty?



      desc = event_entire.at_css('div.action-description p')
      info = event_entire.at_css('table.cells.reference')

      item.full_text=desc.to_html(:encoding => 'UTF-8') if desc
      item.info = info.to_html(:encoding => 'UTF-8')   if info
      item.auto_load= 1
      item.save!
      #################################

    if gallery = Gallery.find_by_name(event_name)
        gallery.item = item
        gallery.save
       else
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
    end
      #################################

      item.save!


      event_data =  event_entire.css('h6 span.red')

      event_data.each do |d|
       data = d.text.split(',').first

        d.parent.next_element.css('td.place').each do |place|
          place_url =domen+place.css('a').first['href']

          t1 =   place.text.split('/')
          place_name =  t1.first.strip
          room_name = t1.last.strip  if t1[1]

         place_o = Place.find_by_name(place_name) || ParseHelper::create_place(place_url)

          place.next_element.css('b').each do |time2|
            time1= time2.text.gsub(',','').strip
           event =  Event.new
          p  event.name="#{place_name}/#{room_name} - #{event_name}"
          p  event.date_begin = "#{data}  #{time1}"
            event.items = [item]
            event.auto_load= 1
            event.place =place_o
            event.save!
          end  if  place.next_element

          # TODO разобраться с нонстопами
          #place.next_element.css('a').each do |a|
          #  item = Item.find_by_title(a.text)
          #  p item.title
          #  event.items << item  if item
          #  event.name = "Нон-стоп #{} "
          #  event.save!
          #end      if place.next_element.css('a')

          p "-----------"
        end
      end
      break



    end



  end









end