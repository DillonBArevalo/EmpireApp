require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many :characters}
    it { should have_many :weapons}
    it { should have_many :armors}
  end
end
