class Item < ActiveRecord::Base
  attr_accessible :title, :date, :full_text  , :category_id , :type_id   , :info
  belongs_to :category   , :conditions => "type_id = 2"
  has_many :galleries
  has_many :events
  has_one :place
  validates :title , :uniqueness => true
end
