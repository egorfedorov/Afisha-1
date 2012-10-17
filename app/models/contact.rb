class Contact < ActiveRecord::Base
  attr_accessible :address, :mail, :place_id, :site, :tel  ,:location
  belongs_to :place
end
