class Item < ActiveRecord::Base
  attr_accessible :title, :date, :full_text  , :type_id   , :info , :auto_load
  has_and_belongs_to_many :categories
  has_many :galleries , :include => :images
  has_and_belongs_to_many :events, :order=> 'date_begin'
  belongs_to :type
  has_many :images  , :through => :galleries
  has_many :places , :through => :events  ,:order=> 'id'

  validates :title , :uniqueness => true




  paginates_per 9

  #define_index do
  #  # fields
  #  indexes title
  #  #indexes items.title, as: :item_title
  #  #has items.id, as: :item_id, facet: true
  #  #has room_id, facet: true
  #  #has place_id, facet: true
  #  #indexes items.categories.id, as: :category_id
  #  #
  #  #has date_begin
  #
  #  # attributes
  #end
  #attr_accessor :main_image  ,:all_images
  #
  #def init
  #   #= self.try(:galleries).try(:first).try(:images).try(:last).try(:image)
  #  #self.images.shift(@main_image)
  #  @all_images = self.try(:galleries).try(:first).try(:images)
  #   @main_image = @all_images.pop.image
  #end

  def main_image
    self.images.first.image
  end

  def schedule
    Schedule.get_by_item(self)
  end





end
