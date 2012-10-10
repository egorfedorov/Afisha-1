class Item < ActiveRecord::Base
  attr_accessible :title, :date, :full_text, :type  , :category_id
  belongs_to :category
end
