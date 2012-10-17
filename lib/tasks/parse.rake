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

    include  ParseHelper

    domen = 'http://www.redom.ru'
    html =   Nokogiri::HTML(open("http://www.redom.ru/afisha/week/cinema/"))


      parent_cat = html.xpath("//table[@class='catlist']/tr/td/span").text

      event_list =  html.css('td.action')   #Список мероприятий


    event_list.each do |elem|      # Пробегаем по списку мероприятий

         event_url =domen + elem.css('h2 a').first['href']

         next  if Item.find_by_title(elem.parent.css('.action a').first.text) # Пропускаем если уже есть такой item

        event_entire =  Nokogiri::HTML(open(event_url))     #Заходим в событие


         p  event_name = event_entire.css('h1.black').text

         item = Item.new(:title =>event_name)
   #############################################
        cat_event = event_entire.css("td.action-reference small.genre").text

        cat_event.split(',').each do |cat|
          #p("Категория не найдена - #{cat}") unless Category.find_by_name(cat.strip)
           Category.create(:name=>cat.strip ,:parent_id=>Category.find_by_name(parent_cat).id,:type_id=>1)    unless Category.find_by_name(cat.strip)
          item.category << Category.find_by_name(cat.strip)

        end

      item.category << Category.find_by_name(parent_cat) if  cat_event.empty?
  ######################################3333


      desc = event_entire.at_css('div.action-description p')
      info = event_entire.at_css('table.cells.reference')

      item.full_text=desc.to_html(:encoding => 'UTF-8') if desc
      item.info = info.to_html(:encoding => 'UTF-8')   if info
      item.auto_load= 1
      item.save!

      #################################

      gallery =  ParseHelper.gallery_parse(event_url)

       gallery.item = item
      gallery.save!
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

         place_o = Place.find_by_name(place_name) || ParseHelper.place_parse(place_url)

          place.next_element.css('b').each do |time2|
            time1= time2.text.gsub(',','').strip
           event =  Event.new
          p  event.name="#{place_name}/#{room_name} - #{event_name}"
          p  event.date_begin = "#{data}  #{time1}"
            event.items = [item]
            event.auto_load= 1
            event.place =place_o
            event.save!

            if place.next_element.css('a')

              place.next_element.css('a').each do |a|
                p a.text
                item = Item.find_by_title(a.text)
                p item.title
                event.items << item  if item
                event.name = "Нон-стоп #{} "
                event.save!
              end
            end

          end  if  place.next_element



          p "-----------"
        end
      end
      break



    end



  end









end