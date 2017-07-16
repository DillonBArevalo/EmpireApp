class CreateWeapons < ActiveRecord::Migration[5.0]
  def change
    create_table :weapons do |t|
      t.references :user
      t.references :weapon_type
      t.string :name
      t.text :description
      t.integer :defense_die_number
      t.integer :defense_die_size
      t.integer :flat_defense_bonus
      t.decimal :defense_energy_modifier
      t.integer :extra_attack_cost
      t.integer :extra_block_cost
      t.integer :hands_used

      t.timestamps
    end
  end
end
