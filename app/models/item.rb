class Item < ActiveRecord::Base
  attr_accessible :title, :date, :full_text, :type_id  , :category_id
  belongs_to :category
end
