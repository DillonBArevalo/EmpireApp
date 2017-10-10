class Armor < ApplicationRecord
  belongs_to :creator, foreign_key: :user_id, class_name: 'User'
  belongs_to :armor_type

  has_many :damage_resistances, -> {order 'damage_type_id ASC'}, dependent: :delete_all
  # has_many :damage_types, through: :damage_resistances

  has_many :characters, foreign_key: :equipped_armor_id

  has_many :obtained_armors, dependent: :delete_all
  has_many :inventories, through: :obtained_armors
  has_many :owners, through: :inventories, source: :character
  has_many :users, through: :owners, source: :creator

  validates :name, :description, :armor_type, :passive_defense_bonus, :active_action_reduction, :budget_reduction, :energy_pool_reduction, :dodge_energy_mod_penalty, :dodge_die_size_reduction, presence: true

  def drs
    damage_resistances.map {|dr| dr.amount}.join('/')
  end

  def generate_drs(array_of_drs)
    array_of_drs.each_with_index do |amount, idx|
      amount = (amount.empty? ? 0 : amount)
      self.damage_resistances.create!(damage_type_id: (idx + 1), amount: amount)
    end
  end
end
