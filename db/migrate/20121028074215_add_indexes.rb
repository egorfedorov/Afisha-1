class AddIndexes < ActiveRecord::Migration
  def change
    add_index :places, :category_id
    add_index :places, :contact_id
    add_index :events, :room_id
    add_index :events, :place_id
    add_index :galleries ,:item_id
    add_index :images ,:gallery_id
    add_index :events_items ,[:item_id , :event_id ]
    add_index :categories ,:parent_id
    add_index :categories_items ,[:item_id,:category_id ]



  end


end
