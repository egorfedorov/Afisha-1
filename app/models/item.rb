class Item < ActiveRecord::Base
  attr_accessible :title, :date, :full_text  , :category_id , :type_id   , :info , :auto_load
  has_and_belongs_to_many :category
  has_and_belongs_to_many :events
  has_many :galleries
  has_and_belongs_to_many :events
  has_one :place
  validates :title , :uniqueness => true
  belongs_to :type
  has_many :images  , :through => :galleries

  def full_category


  end

end
