require 'rails_helper'

RSpec.describe EquippedArmor, type: :model do
  describe 'Associations' do
    it { should belong_to :armor }
    it { should belong_to :character }
  end
end
