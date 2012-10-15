class Event < ActiveRecord::Base
  attr_accessible :date_begin, :item_id, :name, :place_id , :category_id  ,:date_end  ,:auto_load

  belongs_to :place
  belongs_to :item
  belongs_to :category  , :conditions => "type_id = 1"
end
