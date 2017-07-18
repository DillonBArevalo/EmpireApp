require 'rails_helper'

RSpec.describe Armor, type: :model do
  describe 'Associations' do

    describe '#creator' do
      it {should belong_to :creator}
    end

    describe '#armor_type' do
      it{should belong_to :armor_type}
    end

    describe '#damage_resistances' do
      it{should have_many :damage_resistances}
    end

    describe '#characters' do
      it{should have_many :characters}
    end

    describe '#inventories' do
      it{should have_many :inventories}
    end

    describe '#owners' do
      it{should have_many :owners}
    end

    describe '#users' do
      it{should have_many :users}
    end
  end
end
