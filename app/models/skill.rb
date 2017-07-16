class Skill < ApplicationRecord
  has_many :skill_costs
  belongs_to :skillable, polymorphic: true

  has_many :obtained_skills
  has_many :characters, through: :obtained_skills
end
