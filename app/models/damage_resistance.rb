class DamageResistance < ApplicationRecord
  belongs_to :armor
  belongs_to :damage_type

  validates :amount, presence: true
end
