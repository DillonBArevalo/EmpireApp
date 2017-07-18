require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe 'Associations' do
    it { should belong_to :character}
    it { should have_many :obtained_weapons}
    it { should have_many :weapons}
    it { should have_many :obtained_armors}
    it { should have_many :armors}
  end
end
