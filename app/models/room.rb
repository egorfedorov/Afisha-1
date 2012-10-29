class Room < ActiveRecord::Base
  attr_accessible :name, :place_id
  belongs_to :place
  has_many :events
  validates  :place_id , :presence=>true

end
