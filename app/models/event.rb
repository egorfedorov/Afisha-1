class Event < ActiveRecord::Base
  attr_accessible :date_begin,  :name, :place_id , :category_id  ,:date_end  ,:auto_load , :room_id

  belongs_to :place
  belongs_to :room
  has_and_belongs_to_many :items
  #has_many :categories, through: :items
  validates :name ,  :uniqueness => { :scope => [:date_begin, :place_id, :name, :room_id]}

  paginates_per 5

  define_index do
    # fields
    indexes name
    indexes items.title, as: :item_title
    has items.id, as: :item_id, facet: true
    has room_id, facet: true
    has place_id, facet: true
    indexes items.categories.id, as: :category_id

    has date_begin

    # attributes
  end


end
