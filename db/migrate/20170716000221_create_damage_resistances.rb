class CreateDamageResistances < ActiveRecord::Migration[5.0]
  def change
    create_table :damage_resistances do |t|
      t.references :armor
      t.references :damage_type
      t.integer :amount

      t.timestamps
    end
  end
end
