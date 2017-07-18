require 'rails_helper'

RSpec.describe SkillCost, type: :model do
  describe 'Associations' do
    it { should belong_to :skill}
  end
end
