class Event < ActiveRecord::Base
  attr_accessible :date_begin, :item_id, :name, :place_id , :category_id

  belongs_to :place
  belongs_to :item
  belongs_to :category
end
