#coding=utf-8
module ParseHelper

 def self.create_place (url)
    html =   Nokogiri::HTML(open(url))
    name = html.css('h1').text
    desc =  html.css('div.item-xdata').text
    place =Place.new
    place.name= name
    place.desc =desc
    address=html.at_xpath('//tr/td[text()="Адрес"]').try(:next_element)
    tel=html.at_xpath('//tr/td[text()="Телефон"]').try(:next_element)
    mail=html.at_xpath('//tr/td[text()="E-mail"]').try(:next_element)
    place.create_contact(:address=> address, :tel=>tel, :mail=>mail)
    place.save!
     place
  end

end