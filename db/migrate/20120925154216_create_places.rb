class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.integer :category_id
      t.text :desc
      t.integer :contact_id
      t.boolean :auto_load
      t.timestamps
    end
  end
end
