#coding=utf-8

desc "Parse  событий v0.2 current"
task :item_parse_2 => :environment do |t, arg|

  @@events_count = 0

  include ParseHelper
  #-----------------------------------
  #input_url = 'http://www.redom.ru/afisha/week/exhibitions/'
  #input_url = 'http://www.redom.ru/afisha/month/shows/'
  input_url = 'http://www.redom.ru/afisha/week/cinema/'
  #input_url = 'http://www.redom.ru/afisha/month/concerts/'
  #input_url = 'http://www.redom.ru/afisha/month/parties/'
  #input_url = 'http://www.redom.ru/afisha/month/education/'

  domen = 'http://www.redom.ru'

  html = Nokogiri::HTML(open(input_url))


  #----------------------------------

  parent_cat = html.xpath("//table[@class='catlist']/tr/td/span").text

     @items_count = 0
  event_list = html.css('td.action') #Список мероприятий

   dates=html.xpath("//h6/span[@class='red']/..")

   dates.each do |date|

      date.next_element.xpath("//td[@class='action']").each do |item_html|

        tr_item = item_html.parent

        begin
          item_name = tr_item.css('.action').text
           @items_count += 1 unless item_name.blank?

         tr_item = tr_item.next_element

        end while !tr_item.css('.action')





        #k = temp1.next_element.css('.action')
        #item_html = ''
        #while k.blank?
        #  k = temp1.next_element.css('.action')

        #end


      end

      p @items_count

   end


end