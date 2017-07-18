require 'rails_helper'

RSpec.describe ObtainedWeapon, type: :model do
  describe 'Associations' do
    it {should belong_to :weapon}
    it {should belong_to :inventory}
  end
end
