class CreateAttackOptionsConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :attack_options_conditions do |t|
      t.references :attack_option
      t.references :condition
      t.integer :threshold

      t.timestamps
    end
  end
end
