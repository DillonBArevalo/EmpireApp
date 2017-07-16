class ObtainedWeapon < ApplicationRecord
  belongs_to :weapon
  belongs_to :inventory
end
