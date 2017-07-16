class CreateObtainedArmors < ActiveRecord::Migration[5.0]
  def change
    create_table :obtained_armors do |t|
      t.references :inventory
      t.references :armor

      t.timestamps
    end
  end
end
