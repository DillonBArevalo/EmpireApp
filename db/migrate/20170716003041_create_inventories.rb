class CreateInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :inventories do |t|
      t.references :character

      t.timestamps
    end
  end
end
