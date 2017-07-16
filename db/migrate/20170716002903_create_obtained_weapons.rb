class CreateObtainedWeapons < ActiveRecord::Migration[5.0]
  def change
    create_table :obtained_weapons do |t|
      t.references :weapon
      t.references :inventory

      t.timestamps
    end
  end
end
