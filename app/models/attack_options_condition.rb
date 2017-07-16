class AttackOptionsCondition < ApplicationRecord
  belongs_to :attack_option
  belongs_to :condition
end
