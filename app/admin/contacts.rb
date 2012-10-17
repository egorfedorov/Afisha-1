ActiveAdmin.register Contact do
  index do
    selectable_column

    column :mail
    column :tel
    column :address
    column :location
    column :site
    column :place



    default_actions
  end
  
end
