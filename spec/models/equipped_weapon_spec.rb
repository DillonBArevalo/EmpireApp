require 'rails_helper'

RSpec.describe EquippedWeapon, type: :model do
  describe 'Associations' do
    it { should belong_to :weapon}
    it { should belong_to :character}
  end
end
