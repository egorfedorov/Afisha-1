class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.text :desc
      t.integer :type_id
      t.integer :item_id

      t.timestamps
    end
  end
end
