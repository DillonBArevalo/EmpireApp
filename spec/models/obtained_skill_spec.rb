require 'rails_helper'

RSpec.describe ObtainedSkill, type: :model do
  describe 'Associations' do
    it{ should belong_to :skill}
    it{ should belong_to :character}
    it{ should belong_to :applicable_weapon_class}
  end
end
