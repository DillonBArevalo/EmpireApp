require 'rails_helper'

RSpec.describe WeaponClassesWeapon, type: :model do
  describe 'Associations' do
    it {should belong_to :weapon_class}
    it {should belong_to :weapon}
  end
end
