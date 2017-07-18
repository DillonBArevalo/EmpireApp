require 'rails_helper'

RSpec.describe AttackOptionsCondition, type: :model do
  describe 'Associations' do

    describe '#attack_option' do
      it{should belong_to :attack_option}
    end

    describe '#condition' do
      it{should belong_to :condition}
    end
  end
end
