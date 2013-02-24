class Category < ActiveRecord::Base
  acts_as_nested_set
  include TheSortableTree::Scopes
  attr_accessible :desc, :name, :type_id   ,:parent_id

  validates :name , :uniqueness => true
  validates_each :parent_id   do |record, attr, value|
    if value
       cat = Category.find(value)
       record.errors.add(attr, 'it  should not refer to itself') if record.id == value
       record.errors.add(attr, 'it should same type') if cat.type_id != record.type_id
    end

  end



  has_and_belongs_to_many :items
  belongs_to :type
  has_many :events
  has_many :places
  has_one :parent_category , :class_name=>:category , :foreign_key => :parent_id

  def schedule
    Schedule.get_by_category(self)
  end

  def parent_category
    self.parent
  end

  def items_in_category
    items= Item.joins(:categories).where(:categories_items=>{:category_id =>self.self_and_descendants})
    Item.includes(:categories,:galleries=>:images).where(:id=>(items.select{id}))
  end


end
