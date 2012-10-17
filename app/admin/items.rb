ActiveAdmin.register Item do


  index do
   selectable_column
    column :id
   column :photo  do |item|
     image_tag item.galleries.first.images.first.image.url('thumb')   unless item.galleries.empty?
   end
    column :title  , :width=>'200'
    column :info do |item|
      sanitize item.info
      #item.info.sanitize.html_safe
    end
    column 'Desc' do |item|
       HTML_Truncator.truncate( item.full_text ,50 ).html_safe
    end
    column :auto_load
    column :type
    #column :type_id


    default_actions
  end

  
end
