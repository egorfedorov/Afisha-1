class FixItem < ActiveRecord::Migration
  def up
    remove_column :items, :category_id
  end

  def down
  end
end
