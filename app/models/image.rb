class Image < ActiveRecord::Base
  attr_accessible :gallery_id, :name
  belongs_to :gallery

  has_attached_file :image,:styles =>
      { :large=>"800x800",  :medium => "300x300>", :thumb => "100x100>"  }

end
