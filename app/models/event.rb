class Event < ActiveRecord::Base
  attr_accessible :date_begin,  :name, :place_id , :category_id  ,:date_end  ,:auto_load

  belongs_to :place
  has_and_belongs_to_many :items
  belongs_to :category  , :conditions => "type_id = 1"
  validates :name ,  :uniqueness => { :scope => [:date_begin, :place_id, :name]}

  paginates_per 5


end
