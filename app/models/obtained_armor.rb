class ObtainedArmor < ApplicationRecord
  belongs_to :inventory
  belongs_to :weapon
end
