ActiveAdmin.register Item do


  index do
    column :id
    column :title
    column :info
    column 'Desc' do |item|
       HTML_Truncator.truncate( item.full_text ,10 )
    end
    column :auto_load



    default_actions
  end

  
end
