ActiveAdmin.register Event do


  index do
    selectable_column
    column :id
    column :name
    column :date_begin
    column :place
    column :room
    column 'Category' do |e|
      l = []
      e.items.first.categories.each do |item|
      l << link_to(item.name ,admin_category_path(item))
        end if !e.items.empty?
        l.join(',').html_safe
    end
    column "Items"  do |e|
      l = []
        e.items.each do |item|
       l << link_to(item.title ,item_path(item))

        end
      l.join(',').html_safe
    end

    default_actions
  end


end
