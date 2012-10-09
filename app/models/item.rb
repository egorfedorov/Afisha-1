class Item < ActiveRecord::Base
  attr_accessible :title, :date, :full_text, :type
  belongs_to :category, as=>:categorized
end
