require 'rails_helper'

RSpec.describe ArmorType, type: :model do
  describe 'Associations' do
    describe '#armors' do
      it{should have_many :armors}
    end
  end
end
