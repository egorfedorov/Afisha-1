class ItemPlaces < ActiveRecord::Migration
  def change
    create_table :events_items ,  :id => false do |t|
      t.integer :item_id
      t.integer :event_id

    end
  end
end
