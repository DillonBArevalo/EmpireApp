require 'rails_helper'

RSpec.describe Character, type: :model do
  describe 'Associations' do
    it{should belong_to :creator}
    it{should have_many :character_classes}
    it{should have_many :possible_class_skills}
    it{should have_many :improved_weapon_classes}
    it{should have_many :skills}
    it{should have_one :inventory}
    it{should have_many :weapons}
    it{should have_many :armors}
    it{should have_one :equipped_armor}
    it{should have_many :equipped_weapons}
    it{should have_many :attack_options}
  end

  let(:character) {Character.new(name: 'test', description: 'tester', strength: 10, dexterity: 10, constitution: 10)}
  describe 'Extra stats' do
    describe '#active_defense_bonus' do
      it 'returns an integer active_defense_bonus' do
        expect(character.active_defense_bonus.integer?).to be true
        expect(character.active_defense_bonus).to eq(7)
      end
    end
    describe '#active_offense_bonus' do
      it 'returns an integer active_offense_bonus' do
        expect(character.active_offense_bonus.integer?).to be true
        expect(character.active_offense_bonus).to eq(10)
      end
    end
    describe '#energy_budget' do
      it 'returns an integer energy_budget' do
        expect(character.energy_budget.integer?).to be true
        expect(character.energy_budget).to eq(14)
      end
      it 'is modified by an energy_budget_level_bonus' do
        character.energy_budget_level_bonus = 10
        expect(character.energy_budget).to eq(24)
      end
    end
    describe '#energy_pool' do
      it 'returns an integer energy_pool' do
        expect(character.energy_pool.integer?).to be true
        expect(character.energy_pool).to eq(250)
      end
      it 'is modified by an energy_pool_level_bonus' do
        character.energy_pool_level_bonus = 100
        expect(character.energy_pool).to eq(350)
      end
    end
    describe '#hit_points' do
      it 'returns an integer hit_points' do
        expect(character.hit_points.integer?).to be true
        expect(character.hit_points).to eq(50)
      end
    end
    describe '#move_speed' do
      it 'returns an integer move_speed' do
        expect(character.move_speed.integer?).to be true
        expect(character.move_speed).to eq(2)
      end
    end
  end

  xdescribe '#obtain_skill' do

  end

  describe '#tactical_maneuver' do
    it 'adds a d20 to the dex score' do
      expect(character.tactical_maneuver).to eq('10 + 1d20')
    end
  end

  describe '#jump' do
    it 'gives the same number as #tactical_maneuver without the relevant skill' do
      expect(character.jump).to eq(character.tactical_maneuver)
    end

    xit 'adds a dex die with the relevant skill' do
      character.obtain_skill(Skill.find_by(name: 'Lightning Reflexes'))
      expect(character.jump).to eq(character.tactical_maneuver + ' + 1d4')
    end
  end

  xdescribe '#equip_weapon' do
  end

  xdescribe '#generate_attack_string' do
    it 'should generate an appropriate attack string without skills' do

    end
    describe 'stat dice effects' do
      it 'should add to the number of dice if the stat die is of the same size as the attack die' do

      end
      it 'should add new dice if the stat die is of a different size to the attack die' do

      end
      it 'should add multiple new dice if strength and dex dice are different (in order of str then dex)' do

      end
    end
  end

  xdescribe '#generate_damage_string' do

  end

  xdescribe '#generate_defense_string' do

  end
end
