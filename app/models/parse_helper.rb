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
    location=html.at_xpath('//tr/td[text()="Район"]').try(:next_element).try(:text)
    tel=html.at_xpath('//tr/td[text()="Телефон"]').try(:next_element).try(:text)
    mail=html.at_xpath('//tr/td[text()="E-mail"]').try(:next_element).try(:text)
    site=html.at_xpath('//tr/td[text()="Сайт"]').try(:next_element).try(:text)
   @contacts_count+=1 if  place.create_contact(:address=> address, :tel=>tel, :mail=>mail ,:site=>site ,:location=>location)
   place.save!
  @places_count+=1

    place
  end
#Парсит картинки в галерею
 def gallery_parse (url, item_html=nil )

   item_html ||=  Nokogiri::HTML(open(url))
   event_name = item_html.css('h1.black').text

   gallery = Gallery.find_by_name(event_name) || Gallery.new( :name=>event_name)

   if gallery.new_record?
     if image1 = item_html.at_css('td.action-picture a')

     im = Image.new
     im.image = open image1['href']
     im.gallery = gallery
     im.save!
    end

     images =item_html.css('td.action-picture div.trailers a img')
     images.each do |image|
       im = Image.new
       im.image =open image.parent['href']
       im.gallery = gallery
       im.save!
       @images_count+=1
     end   if images

      gallery.save!
     @galleries_count+=1
   else

     p  "#{gallery.name} -- уже есть в базе"
   end

   gallery
 end

 def item_parse ( parent_cat, url, item_html=nil)

   item_html ||=  Nokogiri::HTML(open(url))
   p  item_name = item_html.css('h1.black').text

      item =  Item.find_by_title(item_name) ||  Item.new(:title =>item_name) # Пропускаем если уже есть такой item

    if item.new_record?
      cat_item = item_html.css("td.action-reference small.genre").text

      cat_item.split(',').each do |cat|
        #p("Категория не найдена - #{cat}") unless Category.find_by_name(cat.strip)
        Category.create(:name=>cat.strip ,:parent_id=>Category.find_by_name(parent_cat).id,:type_id=>1)    unless Category.find_by_name(cat.strip)
        item.category << Category.find_by_name(cat.strip)
      end

      item.category << Category.find_by_name(parent_cat) if  cat_item.empty?

      desc = item_html.at_css('div.action-description p')
      info = item_html.at_css('table.cells.reference')

      item.full_text=desc.to_html(:encoding => 'UTF-8') if desc
      item.info = info.to_html(:encoding => 'UTF-8')   if info
      item.auto_load= 1
      item.save!
      @items_count +=1
    else
      p  "#{item.title} -- уже есть в базе"
    end
   item

 end



end