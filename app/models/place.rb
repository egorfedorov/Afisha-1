class Place < ActiveRecord::Base
  attr_accessible :category_id, :contact_id, :desc, :name  , :item_id ,:auto_load
  has_many :events
  belongs_to :item
  belongs_to :category           , :conditions => "type_id = 3"
end
