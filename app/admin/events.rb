ActiveAdmin.register Event do


  index do
    selectable_column
    column :name
    column :date_begin
    column :place

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
