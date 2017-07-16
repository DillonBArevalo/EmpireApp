class CreateSkillCosts < ActiveRecord::Migration[5.0]
  def change
    create_table :skill_costs do |t|
      t.references :skill
      t.integer :rank
      t.integer :cost

      t.timestamps
    end
  end
end
