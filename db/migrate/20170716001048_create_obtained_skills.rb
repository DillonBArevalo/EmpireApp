class CreateObtainedSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :obtained_skills do |t|
      t.references :skill
      t.references :character
      t.references :applicable_weapon_class, references: :weapon_class
      t.integer :ranks

      t.timestamps
    end
  end
end
