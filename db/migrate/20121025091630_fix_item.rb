class FixItem < ActiveRecord::Migration
  def up
    remove_column :items, :category_id
    remove_column :events ,:item_id
  end

  def down
  end
end
