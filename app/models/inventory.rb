class Inventory < ApplicationRecord
  belongs_to :character

  has_many :obtained_weapons, -> { order 'weapon_id ASC' }
  has_many :weapons, through: :obtained_weapons

  has_many :obtained_armors, -> { order 'armor_id ASC' }
  has_many :armors, through: :obtained_armors

  # to_h these to make the cleaner in the erb?
  def weapons_and_joins
    self.weapons.zip(self.obtained_weapons)
  end
  def armors_and_joins
    self.armors.zip(self.obtained_armors)
  end

end
