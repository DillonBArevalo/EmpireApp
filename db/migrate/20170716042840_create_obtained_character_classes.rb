class CreateObtainedCharacterClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :obtained_character_classes do |t|
      t.references :character
      t.references :character_class
      t.integer :invested_points

      t.timestamps
    end
  end
end
