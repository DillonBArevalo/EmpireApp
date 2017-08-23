class Armor < ApplicationRecord
  belongs_to :creator, foreign_key: :user_id, class_name: 'User'
  belongs_to :armor_type

  has_many :damage_resistances
  # has_many :damage_types, through: :damage_resistances

  has_many :characters, foreign_key: :equipped_armor_id

  has_many :obtained_armors
  has_many :inventories, through: :obtained_armors
  has_many :owners, through: :inventories, source: :character
  has_many :users, through: :owners, source: :creator
end
