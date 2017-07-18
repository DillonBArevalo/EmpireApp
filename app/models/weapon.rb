class Weapon < ApplicationRecord
  belongs_to :user
  belongs_to :weapon_type

  has_many :weapon_classes_weapons
  has_many :weapon_classes, through: :weapon_classes_weapons
  has_many :skills, through: :weapon_classes
  has_many :skill_costs, through: :skills

  has_many :attack_options
  has_many :damage_types, through: :attack_options
  has_many :attack_options_conditions, through: :damage_types
  has_many :conditions, through: :attack_options_conditions

  has_many :equipped_weapons
  has_many :characters, through: :equipped_weapons

  has_many :obtained_weapons
  has_many :inventories, through: :obtained_weapons

end
