class Room < ActiveRecord::Base
  attr_accessible :name, :place_id
  belongs_to :place
  validates  :place_id , :presence=>true

end
