require 'rails_helper'

RSpec.describe Character, type: :model do
  describe 'Associations' do

    describe '#creator' do
      it{should belong_to :creator}
    end

    describe '#character_classes' do
      it{should have_many :character_classes}
    end

    describe '#possible_class_skills' do
      it{should have_many :possible_class_skills}
    end

    describe '#improved_weapon_classes' do
      it{should have_many :improved_weapon_classes}
    end

    describe '#skills' do
      it{should have_many :skills}
    end

    describe '#inventory' do
      it{should have_one :inventory}
    end

    describe '#weapons' do
      it{should have_many :weapons}
    end

    describe '#armors' do
      it{should have_many :armors}
    end

    describe '#equipped_armor' do
      it{should have_one :equipped_armor}
    end

    describe '#equipped_weapons' do
      it{should have_many :equipped_weapons}
    end

    describe '#attack_options' do
      it{should have_many :attack_options}
    end

  end
end
