class EquippedArmor < ApplicationRecord
  belongs_to :armor
  belongs_to :character
end
