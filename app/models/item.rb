class Item < ActiveRecord::Base
  attr_accessible :title, :date, :full_text  , :category_id , :type_id   , :info , :auto_load
  has_and_belongs_to_many :categories
  has_many :galleries
  has_and_belongs_to_many :events
  #has_one :place
  has_many :places , :through => :events
  validates :title , :uniqueness => true
  belongs_to :type
  has_many :images  , :through => :galleries

  paginates_per 9

  def main_image
    self.try(:galleries).try(:first).try(:images).try(:first).try(:image)
  end

end
