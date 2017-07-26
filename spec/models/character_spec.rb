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
    it 'should return a hash with keys status and messages' do
      expect(character.obtain_skill(Skill.first).keys).to eq([:status, :messages])
    end

    it 'should return an array of error strings if it failed (status == false)' do
      response = character.obtain_skill(Skill.first)
      expect(response[:status]).to be false
      expect(response[:messages]).to be_kind_of(Array)
      expect(response[:messages][0]).to be_kind_of(String)
    end

    it 'should return the appropriate error messages upon: insufficient skill points, maximum skill level achieved, '
  end

  # xdescribe '#obtain_armor' do

  # end

  # xdescribe '#obtain_weapon' do

  # end

  xdescribe 'class_skills_bonus' do

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

  describe '#equip_weapon' do
    it 'returns false if weapon could not be equipped (not enough hands)' do
      shields = WeaponClass.new(name: 'Shields')
      shield = Weapon.new(name: 'Light Shield', description: '', defense_die_number: 1, defense_die_size: 10, flat_defense_bonus: 4, defense_energy_modifier: 2, extra_block_cost: 30, hands_used: 1)
      shield.weapon_classes << shields
      b_axe = Weapon.new(name: 'Battle Axe', description: '', defense_die_number: 1, defense_die_size: 10, flat_defense_bonus: 5, defense_energy_modifier: 1, extra_block_cost: 30, extra_attack_cost: 30, hands_used: 2, dodge_energy_mod_penalty: 0.5)
      character.equip_shield(shield)
      expect(character.equip_weapon(b_axe)).to be false
    end
    it 'adds an equipped weapon to character.equipped_weapons' do
      b_axe = Weapon.new(name: 'Battle Axe', description: '', defense_die_number: 1, defense_die_size: 10, flat_defense_bonus: 5, defense_energy_modifier: 1, extra_block_cost: 30, extra_attack_cost: 30, hands_used: 2, dodge_energy_mod_penalty: 0.5)
      character.equip_weapon(b_axe)
      expect(character.equipped_weapons).to include(b_axe)
    end
    it 'will remove currently equipped weapon if incompatible (2 non-shields)' do
      b_axe = Weapon.new(name: 'Battle Axe', description: '', defense_die_number: 1, defense_die_size: 10, flat_defense_bonus: 5, defense_energy_modifier: 1, extra_block_cost: 30, extra_attack_cost: 30, hands_used: 2, dodge_energy_mod_penalty: 0.5)
      character.equip_weapon(b_axe)
      h_axe = Weapon.new(name: 'Hand Axe', description: "", defense_die_number: 1, defense_die_size: 6, flat_defense_bonus: 5, defense_energy_modifier: 0.5, extra_block_cost: 25, extra_attack_cost: 25, hands_used: 1)
      character.equip_weapon(h_axe)
      expect(character.equipped_weapons).to include(h_axe)
      expect(character.equipped_weapons.length).to eq(1)
    end
  end

  xdescribe '#equip_shield' do
  end

  describe '#free_hands' do
    it 'returns the number of free hands a character has' do
      expect(character.free_hands).to eq(2)

      shield = Weapon.new(hands_used: 1)
      character.equipped_weapons << shield
      expect(character.free_hands).to eq(1)

      h_axe = Weapon.new(name: 'Hand Axe', description: "", defense_die_number: 1, defense_die_size: 6, flat_defense_bonus: 5, defense_energy_modifier: 0.5, extra_block_cost: 25, extra_attack_cost: 25, hands_used: 1)
      character.equipped_weapons << h_axe
      expect(character.free_hands).to eq(0)
    end
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
