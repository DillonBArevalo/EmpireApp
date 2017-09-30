class CreateObtainedClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :obtained_classes do |t|
      t.references :character
      t.references :classable, polymorphic: true
      t.integer :invested_points, default: 0

      t.timestamps
    end
  end
end
