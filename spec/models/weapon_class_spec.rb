require 'rails_helper'

RSpec.describe WeaponClass, type: :model do
  describe 'Associations' do
    it { should have_many :skills}
    it { should have_many :skill_costs}

    it { should have_many :weapon_classes_weapons}
    it { should have_many :weapons}
    it { should have_many :weapon_types}
  end
end
