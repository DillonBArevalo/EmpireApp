require 'rails_helper'

RSpec.describe WeaponType, type: :model do
  describe 'Associations' do
    it { should have_many :weapons }
  end
end
