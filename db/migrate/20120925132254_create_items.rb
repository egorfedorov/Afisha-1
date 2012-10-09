class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.text :full_text
      t.datetime :date
      t.integer :type


      t.timestamps
    end
  end
end
