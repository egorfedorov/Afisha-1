class ItemCategory < ActiveRecord::Migration
  def change
    create_table :categories_items ,  :id => false do |t|
      t.integer :item_id
      t.integer :category_id

    end
  end
end
