require 'rails_helper'

RSpec.describe ObtainedCharacterClass, type: :model do
  describe 'Associations' do
    it { should belong_to :character }
    it { should belong_to :character_class }
  end
end
