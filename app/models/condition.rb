class Condition < ApplicationRecord
  has_many :attack_options_conditions
  has_many :attack_options, through: :attack_options_conditions
  has_many :damage_types, through: :attack_options
  has_many :weapons, through: :attack_options
  has_many :weapon_classes, through: :weapons
end
