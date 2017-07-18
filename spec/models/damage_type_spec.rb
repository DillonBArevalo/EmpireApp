require 'rails_helper'

RSpec.describe DamageType, type: :model do
  describe 'Associations' do
    it{ should have_many :damage_resistances}
    it{ should have_many :attack_options}
    it{ should have_many :conditions}
    it{ should have_many :weapons}
    it{ should have_many :weapon_classes}
  end
end
