class EquippedWeapon < ApplicationRecord
  belongs_to :weapon
  belongs_to :character
end
