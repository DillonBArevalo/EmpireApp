class Skill < ApplicationRecord
  has_many :skill_costs
  belongs_to :skillable, polymorphic: true

  has_many :obtained_skills
  has_many :characters, through: :obtained_skills

  def cost_at_rank(rank)
    skill_cost = SkillCost.find_by(skill_id: self.id, rank: rank)
    if skill_cost
      skill_cost.cost
    else
      skill_cost
    end
  end
end
