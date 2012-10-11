class ApplicationController < ActionController::Base
  protect_from_forgery


  def parse
  html =   Nokogiri::HTML(open("http://www.redom.ru/afisha/details/8876/"))
  table =  html.css('table.catlist')
   table =table.css('a')
  table.each do |elem|
     Category.create(:name=>elem.text , :type_id=>1)
  end

  end
end
