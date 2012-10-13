class Category < ActiveRecord::Base
  acts_as_nested_set
  attr_accessible :desc, :name, :type_id   ,:parent_id

  validates :name , :uniqueness => true
  validates_each :parent_id   do |record, attr, value|
    if value
       cat = Category.find(value)
       record.errors.add(attr, 'it  should not refer to itself') if record.id == value
       record.errors.add(attr, 'must same type') if cat.type_id != record.type_id
    end

  end


  belongs_to :type
  has_many :events
  has_many :places
  has_one :parent_category , :class_name=>:category , :foreign_key => :parent_id






end
