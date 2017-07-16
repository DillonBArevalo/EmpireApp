class Character < ApplicationRecord
  belongs_to :creator, foreign_key: :user_id, class_name: 'User'

  has_many :obtained_character_classes
  has_many :character_classes, through: :obtained_character_classes
  has_many :possible_skills, through: :character_classes, source: :skills
  has_many :possible_skill_costs, through: :possible_skills, source: :skill_costs

  has_many :obtained_skills
  has_many :improved_weapon_classes, through: :obtained_skills, source: :applicable_weapon_class
  has_many :skills, through: :obtained_skills
  has_many :skill_costs, through: :skills

  has_one :inventory

  has_many :obtained_weapons, through: :inventory
  has_many :weapons, through: :obtained_weapons
  has_many :weapon_types, through: :weapons

  has_many :obtained_armors, through: :inventory
  has_many :armors, through: :obtained_armors
  has_many :armor_types, through: :armors

  has_one :equipped_a, class_name: 'EquippedArmor'
  has_one :equipped_armor, through: :equipped_a, source: :armor
  has_one :equipped_armor_type, through: :equipped_armor, source: :armor_type
  has_many :damage_resistances, through: :equipped_armor

  has_many :equipped_w, class_name: 'EquippedWeapon'
  has_many :equipped_weapons, through: :equipped_w, source: :weapon
  has_many :equipped_weapon_types, through: :equipped_weapons, source: :weapon_type
  has_many :attack_options, through: :equipped_weapons

end
