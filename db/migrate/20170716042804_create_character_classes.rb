class CreateCharacterClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :character_classes do |t|
      t.string :name
      t.text :description
      t.string :motto

      t.timestamps
    end
  end
end
