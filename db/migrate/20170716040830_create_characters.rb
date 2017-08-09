class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.references :user
      t.string :name
      t.text :description
      t.integer :strength
      t.integer :dexterity
      t.integer :constitution
      t.integer :intelligence
      t.integer :wisdom
      t.integer :charisma
      t.integer :energy_budget_level_bonus, default: 0
      t.integer :energy_pool_level_bonus, default: 0
      t.integer :total_skill_points, default: 0
      t.integer :available_skill_points, default: 0
      t.integer :unspent_energy_upgrade_points, default: 0

      t.timestamps
    end
  end
end
