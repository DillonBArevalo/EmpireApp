class WeaponClass < ApplicationRecord
  has_many :skills, as: :skillable
  has_many :skill_costs, through: :skills

  has_many :weapon_classes_weapons
  has_many :weapons, through: :weapon_classes_weapons
  has_many :weapon_types, through: :weapons

end
