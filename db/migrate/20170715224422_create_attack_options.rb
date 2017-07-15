class CreateAttackOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :attack_options do |t|
      t.string :name
      t.text :description
      t.references :weapon
      t.references :damage_type
      t.integer :strength_dice
      t.integer :dexterity_dice
      t.decimal :energy_modifier
      t.integer :die_number
      t.integer :die_size
      t.integer :damage_dice
      t.integer :damage_die_size
      t.integer :strength_damage_bonus
      t.integer :dexterity_damage_bonus
      t.integer :flat_damage_bonus

      t.timestamps
    end
  end
end
