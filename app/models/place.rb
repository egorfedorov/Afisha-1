class Place < ActiveRecord::Base
  attr_accessible :category_id, :contact_id, :desc, :name  , :item_id ,:auto_load
  has_many :events
  has_many :rooms
  has_one :contact  , :dependent => :destroy
  belongs_to :item
  belongs_to :category           , :conditions => "type_id = 3"
  validates :name , :uniqueness => true
  paginates_per 5
end
