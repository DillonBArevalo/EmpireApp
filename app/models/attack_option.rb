class AttackOption < ApplicationRecord
  belongs_to :weapon
  has_many :weapon_classes, through: :weapon
  belongs_to :damage_type

  has_many :attack_options_conditions
  has_many :conditions, through: :attack_options_conditions

  validates :name, :weapon, :damage_type, :energy_modifier, :die_number, :die_size, :attack_bonus, :damage_dice, :damage_die_size, :flat_damage_bonus, presence: true
end
