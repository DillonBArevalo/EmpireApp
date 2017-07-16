class DamageType < ApplicationRecord
  has_many :damage_resistances

  has_many :attack_options
  has_many :conditions, through: :attack_options
  has_many :weapons, through: :attack_options
  has_many :weapon_classes, through: :weapons
end
