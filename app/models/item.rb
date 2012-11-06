class Item < ActiveRecord::Base
  attr_accessible :title, :date, :full_text  , :type_id   , :info , :auto_load
  has_and_belongs_to_many :categories
  has_many :galleries , :include => :images
  has_and_belongs_to_many :events, :order=> 'date_begin'
  #has_one :place
  has_many :places , :through => :events  ,:order=> 'id'
  validates :title , :uniqueness => true
  belongs_to :type
  has_many :images  , :through => :galleries

  paginates_per 9

  define_index do
    # fields
    indexes title
    #indexes items.title, as: :item_title
    #has items.id, as: :item_id, facet: true
    #has room_id, facet: true
    #has place_id, facet: true
    #indexes items.categories.id, as: :category_id
    #
    #has date_begin

    # attributes
  end



  def main_image
    self.try(:galleries).try(:first).try(:images).try(:first).try(:image)
  end


  def schedule
    Schedule.get_by_item(self)
  end




end
