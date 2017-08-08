require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe 'Associations' do
    it { should have_many :skill_costs}
    it { should belong_to :skillable}

    it { should have_many :obtained_skills}
    it { should have_many :characters}
  end

  describe '#cost_at_rank' do
      let(:warrior) {CharacterClass.create!(name: "Warrior", description: 'a description', motto: 'a motto')}
      let(:w_s) {warrior.skills.create(base_class_skill: false, passive: true, display_description: false, is_weapon_boost: true, name: "Wild Strikes (Class 2)", description: "Damage dice size increase for a specified weapon class (Class 2). +d2 per level.", ranks_available: 7, damage_die_boost: 2)}
      let(:costs) {[2, 3, 5, 8, 13, 21, 34]}
    it 'returns the relevant costs of the ranks of a skill' do
      costs.each_with_index do |cost, idx|
        w_s.skill_costs.create(rank: (idx + 1), cost: cost)
      end

      costs.each_with_index do |cost, rank_before|
        expect(w_s.cost_at_rank(rank_before + 1)).to eq(cost)
      end
    end
    it 'returns nil if skill cost not found' do
      expect(w_s.cost_at_rank(costs.length + 1)).to be nil
    end
  end
end
