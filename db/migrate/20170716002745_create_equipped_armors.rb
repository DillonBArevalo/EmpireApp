class CreateEquippedArmors < ActiveRecord::Migration[5.0]
  def change
    create_table :equipped_armors do |t|
      t.references :character
      t.references :armor

      t.timestamps
    end
  end
end
