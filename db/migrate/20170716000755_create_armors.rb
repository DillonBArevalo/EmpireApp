class CreateArmors < ActiveRecord::Migration[5.0]
  def change
    create_table :armors do |t|
      t.references :user
      t.string :name
      t.text :description
      t.references :armor_type
      t.integer :passive_defense_bonus
      t.integer :active_action_reduction
      t.integer :budget_reduction
      t.integer :energy_pool_reduction
      t.integer :dodge_energy_mod_penalty
      t.integer :dodge_die_size_reduction

      t.timestamps
    end
  end
end
