class Condition < ApplicationRecord
  has_many :attack_options_conditions
  has_many :attack_options, through: :attack_options_conditions
  has_many :damage_types, through: :attack_options
  has_many :weapons, through: :attack_options
  has_many :weapon_classes, through: :weapons

  def average_trigger
    return 'no weapons directly cause this condition' if attack_options_conditions.empty?
    attack_options_conditions.reduce(0) {|sum, aoc| sum + aoc.threshold} / attack_options_conditions.length
  end
end
