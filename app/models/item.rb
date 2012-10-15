class Item < ActiveRecord::Base
  attr_accessible :title, :date, :full_text  , :category_id , :type_id   , :info
  has_and_belongs_to_many :category
  has_many :galleries
  has_many :events
  has_one :place
  validates :title , :uniqueness => true


  def full_category


  end

end
