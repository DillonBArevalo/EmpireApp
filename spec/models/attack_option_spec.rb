require 'rails_helper'

RSpec.describe AttackOption, type: :model do
  describe 'Associations' do
    describe '#weapon' do
      it{should belong_to :weapon}
    end

    describe '#damage_type' do
      it{should belong_to :damage_type}
    end

    describe '#conditions' do
      it{should have_many :conditions}
    end

    it{should have_many :weapon_classes}
  end
end
