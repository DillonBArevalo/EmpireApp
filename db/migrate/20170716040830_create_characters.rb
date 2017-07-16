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
      t.integer :energy_budget_level_bonus
      t.integer :energy_pool_level_bonus
      t.integer :attacks_available
      t.integer :blocks_available

      t.timestamps
    end
  end
end
