require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe 'Associations' do
    it { should have_many :skill_costs}
    it { should belong_to :skillable}

    it { should have_many :obtained_skills}
    it { should have_many :characters}
  end
end
