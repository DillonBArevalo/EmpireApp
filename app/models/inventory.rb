class Inventory < ApplicationRecord
  belongs_to :character

  has_many :obtained_weapons
  has_many :weapons, through: :obtained_weapons

  has_many :obtained_armors
  has_many :armors, through: :obtained_armors
end
