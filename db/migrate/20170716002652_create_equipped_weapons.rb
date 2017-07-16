class CreateEquippedWeapons < ActiveRecord::Migration[5.0]
  def change
    create_table :equipped_weapons do |t|
      t.references :weapon
      t.references :character

      t.timestamps
    end
  end
end
