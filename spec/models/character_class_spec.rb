require 'rails_helper'

RSpec.describe CharacterClass, type: :model do
  describe 'Associations' do

    it{should have_many :characters}

    it{should have_many :skills}
    it{should have_many :active_skills}
    it{should have_many :passive_skills}

    it{should have_many :base_class_skills}
  end
end
