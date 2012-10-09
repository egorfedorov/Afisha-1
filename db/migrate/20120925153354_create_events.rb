class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.integer :item_id
      t.integer :place_id
      t.integer :category_id
      t.datetime :date_begin

      t.timestamps
    end
  end
end
