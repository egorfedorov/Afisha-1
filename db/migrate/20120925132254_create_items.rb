class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.text :full_text
      t.text :info
      t.datetime :date
      t.integer :type_id
      t.integer :category_id
      t.boolean :auto_load
      t.timestamps
    end
  end
end
