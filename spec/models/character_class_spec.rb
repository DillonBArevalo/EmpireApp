require 'rails_helper'

RSpec.describe CharacterClass, type: :model do
  describe 'Associations' do

    describe '#characters' do
      it{should have_many :characters}
    end

    describe '#skills' do
      it{should have_many :skills}
    end
  end
end
