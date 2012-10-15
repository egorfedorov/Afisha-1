class Gallery < ActiveRecord::Base
  attr_accessible :desc, :name, :type_id, :item_id

  has_many :images  , :dependent => :destroy

  belongs_to :item
end
