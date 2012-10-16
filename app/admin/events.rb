ActiveAdmin.register Event do


  index do
    column :name
    column :date_begin
    column :place

    column "Items"  do |e|
      e.items.each do |i|
       p link_to i.title ,item_path(i)
      end

    end
    default_actions
  end


end
