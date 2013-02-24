#coding=utf-8
namespace :parser do
  desc "Parse  событий v0.2 current"
  task :item_parse_2 => :environment do |t, arg|


    include ParseHelper
    #-----------------------------------
    #input_url = 'http://www.redom.ru/afisha/week/exhibitions/'
    #input_url = 'http://www.redom.ru/afisha/month/shows/'
    #input_url = 'http://www.redom.ru/afisha/week/cinema/'
    #input_url = 'http://www.redom.ru/afisha/month/concerts/'
    #input_url = 'http://www.redom.ru/afisha/month/parties/'
    #input_url = 'http://www.redom.ru/afisha/month/education/'
    #input_url = 'http://www.redom.ru/afisha/month/theater/'

    urls = %w( http://www.redom.ru/afisha/week/exhibitions/
               http://www.redom.ru/afisha/week/cinema/
               http://www.redom.ru/afisha/month/concerts/
               http://www.redom.ru/afisha/month/shows/
               http://www.redom.ru/afisha/month/parties/
               http://www.redom.ru/afisha/month/education/
               http://www.redom.ru/afisha/month/theater/
                http://www.redom.ru/afisha/month/sport/
              )

    urls.each do |input_url|

      domain = 'http://www.redom.ru'

      item_obj = ''
      @@events_count = 0

      #----------------------------------
      html = Nokogiri::HTML(open(input_url))
      parent_cat = html.xpath("//table[@class='catlist']/tr/td/span").text


      event_list = html.css('td.action') #Список мероприятий

      dates=html.xpath("//h6/span[@class='red']")

      dates.each do |date|

        p date_prep= Date_trans(date.text)

        date.parent.next_element.xpath(".//td[@class='action']").each do |row|


          ###################################################
          tr_item = row.parent
          trigger = true
          nodes = Nokogiri::HTML.fragment('')

          while trigger do
            nodes << tr_item.clone
            tr_item = tr_item.next_element
            break if tr_item.nil?
            trigger = tr_item.css('.action').blank?

          end
          ###############################################
          nodes.css('h2 a').each do |it|
            item_url =domain + it['href']
            p item_n =it.text

            item_obj =Item.find_by_title(item_n) || item_parse(parent_cat, item_url, nil)


          end


          nodes.css('.place').each do |p|


            ################################################
            place_url =domain+p.css('a').first['href']
            t1 = p.text.split('/')
            place_name = t1.first.strip
            room_name = t1.last.strip if t1[1]
            #place_o = Place.find_by_name("#{place_name}") || place_parse(place_url)
            place_o = Place.where("name LIKE :prefix", prefix:"#{place_name}%").first || place_parse(place_url)
            if room_name

              room_o = Room.where(:place_id => place_o.id, :name => room_name).first || Room.create(:name => room_name, :place_id => place_o.id)
            end
            ################################################


            p.next_element.css('b').each do |time|

              time1= time.text.gsub(',', '').strip
              p '------------------'+time1

              #########################
              event = Event.new
              event.name="#{item_obj.title.chomp}"
              p event.date_begin = "#{date_prep} #{time1}"
              event.items = [item_obj] if nodes.css('h2 a').count == 1
              if item_obj.blank?
                raise "Почему то итем не найден и не спарсен "
              end
              event.auto_load = 1
              event.place = place_o
              event.room = room_o

              if  nodes.css('h2 a').count > 1
                nodes.css('h2 a').each do |a|
                  p a.text

                  unless  item2 = Item.find_by_title(a.text)
                    item2 = item_parse(parent_cat, domain+a['href'])
                  end

                  event.name = "Нон-стоп"
                  event.items << item2 if item2
                end
              end
              if  event.save
                @@events_count +=1
              else
                p "Событие #{event.name} -- уже есть в базе"

              end

              #########################

            end if p.next_element
          end

        end


        p "-----------------------------------"
        p "Items:#{@@items_count},  Событий:#{@@events_count}, Галерей:#{@@galleries_count},   Картинок:#{@@images_count}, Мест:#{@@places_count} Контактов:#{@@contacts_count} "


      end

    end
  end
end
