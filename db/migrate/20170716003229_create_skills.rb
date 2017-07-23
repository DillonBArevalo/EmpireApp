class CreateSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :skills do |t|
      t.boolean :base_class_skill, default: false
      t.boolean :display_description, default: true
      t.references :skillable, polymorphic: true
      t.string :name
      t.text :description
      t.boolean :passive, default: false
      t.boolean :tactical_maneuver_dex_bonus, default: false
      t.boolean :is_weapon_boost
      t.integer :weapon_class
      t.integer :ranks_available, default: 0
      t.integer :damage_boost, default: 0
      t.integer :damage_die_boost, default: 0
      t.integer :accuracy_boost, default: 0
      t.integer :defense_boost, default: 0
      t.integer :defense_die_boost, default: 0
      t.integer :armor_defense_boost, default: 0
      t.integer :bonus_attacks, default: 0
      t.integer :bonus_blocks, default: 0
      t.decimal :attack_energy_mod_boost, default: 0

      t.timestamps
    end
  end
end
