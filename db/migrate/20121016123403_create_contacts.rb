class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :place_id
      t.string :tel
      t.string :mail
      t.string :site
      t.string :address

      t.timestamps
    end
  end
end
