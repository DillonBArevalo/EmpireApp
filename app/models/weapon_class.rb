class WeaponClass < ApplicationRecord
  has_many :skills, as: :skillable
  has_many :passive_skills, -> {where passive: true, base_class_skill: false}, class_name: 'Skill', as: :skillable
  has_many :active_skills, -> {where passive: false, base_class_skill: false}, class_name: 'Skill', as: :skillable
  has_many :base_class_skills, -> {where base_class_skill: true}, class_name: 'Skill', as: :skillable
  has_many :skill_costs, through: :skills

  has_many :weapon_classes_weapons
  has_many :weapons, through: :weapon_classes_weapons
  has_many :weapon_types, through: :weapons

# tests!
  has_many :equipped_weapons, through: :weapons
  has_many :characters, through: :equipped_weapons
  has_many :obtained_classes, as: :classable

end
