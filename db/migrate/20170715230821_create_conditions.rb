class CreateConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :conditions do |t|
      t.string :name
      t.text :description
      t.text :effect_description

      t.timestamps
    end
  end
end
