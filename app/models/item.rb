class Item < ActiveRecord::Base
  attr_accessible :title, :date, :full_text, :type_id  , :category_id , :auto_load
  belongs_to :category   , :conditions => "type_id = 2"
end
