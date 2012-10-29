#coding=utf-8
namespace :parser do
  desc "Parse категорий событий "
  task :category_parse => :environment do |t, arg|
    domen = 'http://www.redom.ru'
    html = Nokogiri::HTML(open("http://www.redom.ru/afisha/details/8876/"))

    table = html.css('table.catlist')
    table =table.css('a')

    table.each do |elem|
      p elem.text + ' --' + elem['href']
      parent_cat = Category.find_by_name(elem.text) || Category.create(:name => elem.text, :type_id => 1)
      p parent_cat
      sub_cats = Nokogiri::HTML(open(domen+elem['href']))

      sub_cats.at_css('td.genres-container').css('a').each do |sub_cat|
        p '----'+sub_cat.text
        sub_cat = Category.find_by_name(sub_cat.text) || Category.create(:name => sub_cat.text,
                                                                         :parent_id => parent_cat.id,
                                                                         :type_id => 1)
        p sub_cat

      end if   sub_cats.at_css('td.genres-container')
    end


  end
###############################################################
#TODO refactor me

  desc "Parse  событий "
  task :item_parse => :environment do |t, arg|

    @@events_count = 0

    include ParseHelper
    #-----------------------------------
    #input_url = 'http://www.redom.ru/afisha/week/exhibitions/'
    #input_url = 'http://www.redom.ru/afisha/month/shows/'
    #input_url = 'http://www.redom.ru/afisha/week/cinema/'
    input_url = 'http://www.redom.ru/afisha/month/concerts/'
    #input_url = 'http://www.redom.ru/afisha/month/parties/'
    #input_url = 'http://www.redom.ru/afisha/month/education/'

    domen = 'http://www.redom.ru'

    html = Nokogiri::HTML(open(input_url))


    #----------------------------------

    parent_cat = html.xpath("//table[@class='catlist']/tr/td/span").text

    event_list = html.css('td.action') #Список мероприятий

    temp_array = [];

    event_list.each do |elem| # Пробегаем по списку мероприятий
      event = nil
      item= nil

      event_url =domen + elem.css('h2 a').first['href']
      #event_url ='http://www.redom.ru/afisha/details/8978/'

      next if temp_array.include?(event_url)  #Пропускаем поиск , если уже ходили по этому url
      temp_array << event_url
      event_html = Nokogiri::HTML(open(event_url)) #Заходим в событие


      #####################################
      item = item_parse(parent_cat, '', event_html)
      #################################
      gallery = gallery_parse('', event_html)
      gallery.item = item
      gallery.save!
      #################################


      event_data = event_html.css('h6 span.red')

      event_data.each do |d|
        #data = d.text.split(',').first
        data = Date_trans d.text
        d.parent.next_element.css('td.place').each do |place|
          place_url =domen+place.css('a').first['href']

          t1 = place.text.split('/')
       p   place_name = t1.first.strip
        p  room_name = t1.last.strip if t1[1]

          place_o = Place.find_by_name(place_name) || place_parse(place_url)

          if room_name
           room = Room.where(:place_id => place_o.id, :name=>room_name ).first || Room.create(:name=> room_name, :place_id=>place_o.id)
          end

          place.next_element.css('b').each do |time2|
            time1= time2.text.gsub(',', '').strip
            event = Event.new
            p event.name="#{item.title}"
            p event.date_begin = "#{data} #{time1}"
            event.items = [item] if  place.next_element.css('a').blank?
            if item.blank?
              raise "Почему то итем не найден и не спарсен "
            end
            event.auto_load= 1
            event.place =place_o
            event.room=room

            if  place.next_element.css('a')
              place.next_element.css('a').each do |a|
                p a.text
                #Todo Проверить этот код
                unless  item2 = Item.find_by_title(a.text)
                  item2 = item_parse(parent_cat, domen+a['href'])
                end

                event.name = "Нон-стоп"
                event.items << item2 if item2
              end
           end
            if  event.save
              @@events_count +=1
            else
              p  "Событие #{event.name} -- уже есть в базе"

            end




            p "-----------"
          end


        end
      end

      #next if @@events_count < 1

      p "-----------------------------------"
      p "Items:#{@@items_count},  Событий:#{@@events_count}, Галерей:#{@@galleries_count},   Картинок:#{@@images_count}, Мест:#{@@places_count} Контактов:#{@@contacts_count} "

      #break


    end
   p "Поиск осуществлен по  #{temp_array.count} станицам"

  end


end