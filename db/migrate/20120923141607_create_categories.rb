class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :desc
      t.integer :parent_id
      t.integer :type
      t.integer :lft
      t.integer :rgt
      t.integer :depth # this is optional.
      t.timestamps
    end
  end
end
