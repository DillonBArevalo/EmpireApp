class CreateWeaponClassesWeapons < ActiveRecord::Migration[5.0]
  def change
    create_table :weapon_classes_weapons do |t|
      t.references :weapon_class
      t.references :weapon

      t.timestamps
    end
  end
end
