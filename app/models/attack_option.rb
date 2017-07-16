class AttackOption < ApplicationRecord
  belongs_to :weapon
  belongs_to :damage_type

  has_many :attack_options_conditions
  has_many :conditions, through: :attack_options_conditions
end
