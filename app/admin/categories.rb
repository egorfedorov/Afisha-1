ActiveAdmin.register Category do



  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :desc
      f.input :type_id
      f.input :parent
    end

    f.buttons
  end

  index do
    column :name
    column :desc
    column :type_id
    #column "Parent"  do |category|
    # category.parent_category.try(:name)
    #
    #end
    default_actions
  end



end
