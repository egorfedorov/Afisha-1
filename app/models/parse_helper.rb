#coding=utf-8
module ParseHelper

#Пасрит место проведения мероприятия
 def place_parse (url)
    html =   Nokogiri::HTML(open(url))
    name = html.css('h1').text
    desc =  html.css('div.item-xdata').text
    place =Place.new
    place.name= name
    place.desc =desc
    address=html.at_xpath('//tr/td[text()="Адрес"]').try(:next_element).try(:text)
    tel=html.at_xpath('//tr/td[text()="Телефон"]').try(:next_element).try(:text)
    mail=html.at_xpath('//tr/td[text()="E-mail"]').try(:next_element).try(:text)
    place.create_contact(:address=> address, :tel=>tel, :mail=>mail)
    place.save!
    place
  end

 def gallery_parse (url, event_html=nil )

   event_html ||=  Nokogiri::HTML(open(url))
   event_name = event_html.css('h1.black').text

   if gallery = Gallery.find_by_name(event_name)

   return gallery
   else
     gallery = Gallery.new( :name=>event_name)

     images =event_html.css('td.action-picture div.trailers a img')
     images.each do |image|
       im = Image.new
       im.image =open image.parent['href']
       im.gallery = gallery
       im.save!
     end   if images

     image1 = event_html.at_css('td.action-picture a')

     (im = Image.new
     im.image = open image1['href']
     im.gallery = gallery
     im.save! ) if image1

     return gallery
   end

 end

end