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

  validates :user, :weapon_type, :name, :description, :defense_die_number, :defense_die_size, :flat_defense_bonus, :defense_energy_modifier, :extra_attack_cost, :extra_block_cost, :hands_used, presence: true

  def is_shield?
    !self.weapon_classes.select {|type| type.name == 'Shields'}.empty?
  end
end
