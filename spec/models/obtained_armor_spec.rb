require 'rails_helper'

RSpec.describe ObtainedArmor, type: :model do
  describe 'Associations' do
    it { should belong_to :inventory }
    it { should belong_to :armor }
  end
end
