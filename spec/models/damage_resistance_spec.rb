require 'rails_helper'

RSpec.describe DamageResistance, type: :model do
  describe 'Associations' do
    describe '#armor' do
      it{should belong_to :armor}
    end
    describe '#damage_type' do
      it{should belong_to :damage_type}
    end
  end
end
