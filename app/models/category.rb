class Category < ActiveRecord::Base
  acts_as_nested_set
  attr_accessible :desc, :name, :type
  has_many :events
  has_many :places

end
