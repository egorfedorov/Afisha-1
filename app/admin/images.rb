ActiveAdmin.register Image do

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :gallery
      f.input :image  , :as => :file

    end

    f.buttons
  end

  index :as => :grid do |product|
    link_to(image_tag(product.image.url('thumb')), admin_image_path(product))
  end

  
end
