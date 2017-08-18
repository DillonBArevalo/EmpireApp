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
    it{should have_many :class_bcs}
  end

  let(:user) {User.create(username: 'ex', name: 'Tom', email: 'tom@tom.com', password: 'password',password_confirmation: 'password')}
  let(:saved_character) {Character.create(user_id: user.id, name: 'test', description: 'tester', strength: 10, dexterity: 10, constitution: 10)}
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

  describe '#obtain_skill' do

    let(:character_class) {CharacterClass.create(name: 'Ex class', description: 'For testing', motto: 'I help make sure things work!')}
    let(:class_skill) {character_class.skills.create(base_class_skill: false, name: 'tester character class skill', description: 'a skill for testing!', is_weapon_boost: true, weapon_class: 1, ranks_available: 2, passive: true, defense_boost: 5)}
    let!(:class_skill_cost1) {class_skill.skill_costs.create({rank: 1, cost: 10})}
    let!(:class_skill_cost2) {class_skill.skill_costs.create({rank: 2, cost: 4})}
    let!(:class_skill_cost3) {class_skill.skill_costs.create({rank: 2, cost: 4})}
    let(:weapon_class) {WeaponClass.create(name: 'weapon class', description: 'a weapon class!')}
    let(:weapon_skill) {weapon_class.skills.create(name: 'tester weapon skill', description: 'a weapon skill for testing!', ranks_available: 2, passive: true, accuracy_boost: 5)}
    let!(:weapon_skill_cost1) {weapon_skill.skill_costs.create(rank: 1, cost: 10)}
    let!(:weapon_skill_cost2) {weapon_skill.skill_costs.create(rank: 2, cost: 10)}

    it 'returns a hash with keys status and messages' do
      expect(saved_character.obtain_skill(class_skill).keys).to eq([:status, :messages])
    end

    context 'when character fails to obtain skill' do

      it 'returns an array of error strings if it failed (status == false)' do
        response = saved_character.obtain_skill(class_skill)
        expect(response[:status]).to be false
        expect(response[:messages]).to be_kind_of(Array)
        expect(response[:messages][0]).to be_kind_of(String)
      end

      it 'returns the appropriate error messages upon: insufficient skill points, maximum skill level achieved, and class not obtained.' do
        response = saved_character.obtain_skill(class_skill)
        expect(response[:messages][0]).to eq('You do not have the class required to obtain this skill')
        saved_character.add_skill_points(5)
        saved_character.obtain_character_class(character_class)
        response = saved_character.obtain_skill(class_skill)
        expect(response[:messages][0]).to eq("You don't have enough skill points to obtain the next rank of this skill")
        saved_character.add_skill_points(30)
        saved_character.obtain_skill(class_skill)
        saved_character.obtain_skill(class_skill)
        response = saved_character.obtain_skill(class_skill)
        expect(response[:messages][0]).to eq('You have already achieved the maximum rank for this skill')
      end
    end
    context 'when character succeeds in obtaining skill' do
      before(:each) do
        character_class.skills.create(base_class_skill: true, name: 'tester bcs', description: 'a bcs for testing', passive: true)
        saved_character.add_skill_points(100)
        saved_character.obtain_character_class(character_class)
      end

      it 'responds with a successful message' do
        response = saved_character.obtain_skill(class_skill)
        expect(response[:status]).to be true
        expect(response[:messages]).to eq(["#{saved_character.name} successfully obtained #{class_skill.name} at rank 1 for 10 skill points."])
      end

      # need bcs instantiated
      it 'levels up BCS if appropriate' do
        bcs = saved_character.class_bcs
        saved_character.obtain_skill(class_skill)
        obtained_bcs = bcs.map {|skill| ObtainedSkill.find_by(character_id: saved_character.id, skill_id: skill.id)}
        obtained_bcs.each do |skill|
          expect(skill.ranks).to eq 3
        end
      end

      it 'doesn\'t level up bcs if not enough points are added' do
        bcs = saved_character.class_bcs
        saved_character.obtain_skill(class_skill)
        saved_character.obtain_skill(class_skill)
        obtained_bcs = bcs.map {|skill| ObtainedSkill.find_by(character_id: saved_character.id, skill_id: skill.id)}
        obtained_bcs.each do |skill|
          expect(skill.ranks).to eq 3
        end
      end

      it 'notes the affected weapon class on the obtained skill if applicable' do
        saved_character.obtain_skill(class_skill)
        expect(saved_character.obtained_skills.last.applicable_weapon_class_id).to eq 1
      end

      it 'creates a new obtained skill if not obtained yet' do
        expect{saved_character.obtain_skill(class_skill)}.to change{saved_character.obtained_skills.length}
      end
      it 'just upgrades the rank of an obtained skill if you already have it' do
        saved_character.obtain_skill(class_skill)
        saved_character.obtain_skill(class_skill)
        expect(ObtainedSkill.find_by(skill_id: class_skill.id, character_id: saved_character.id).ranks).to eq 2
        expect(saved_character.obtained_skills.length).to eq 2
      end

    end
  end

  describe '#obtain_character_class' do
    let(:character_class) {CharacterClass.create(name: 'Ex class', description: 'For testing', motto: 'I help make sure things work!')}

    it 'returns a hash with keys status and messages' do
      expect(character.obtain_character_class(character_class).keys).to eq([:status, :messages])
    end

    context 'when you cannot obtain the class' do
      it 'returns status false with an appropriate message when not enough sp' do
        saved_character.available_skill_points = 4
        response = saved_character.obtain_character_class(character_class)
        expect(response[:status]).to be false
        expect(response[:messages]).to eq(["test does not have enough available skill points (you have 4) to obtain this class (requires 5)"])
      end
      it 'returns status false with an appropriate message you already have the class' do
        saved_character.available_skill_points = 10
        saved_character.obtain_character_class(character_class)
        response = saved_character.obtain_character_class(character_class)
        expect(response[:status]).to be false
        expect(response[:messages]).to eq(["test already has the class Ex class"])
      end
    end

    context 'when you successfully obtain the class' do
      it 'responds with a positive status and a success message' do
        saved_character.available_skill_points = 10
        response = saved_character.obtain_character_class(character_class)
        expect(response[:status]).to be true
        expect(response[:messages]).to eq(["test has obtained the class Ex class and the associated base class skills!"])
      end
      it 'subtracts 5 from the available_skill_points of the character' do
        saved_character.available_skill_points = 10
        saved_character.obtain_character_class(character_class)
        expect(saved_character.available_skill_points).to eq(5)
      end
      it 'creates an ObtainedCharacterClass with invested_points = 5' do
        saved_character.available_skill_points = 10
        saved_character.obtain_character_class(character_class)
        expect(saved_character.obtained_character_classes.first.invested_points).to eq(5)
      end
      it 'gives the character all the relevant base class skills' do
        bcs = character_class.skills.create(base_class_skill: true, name: 'tester bcs', description: 'a bcs for testing', passive: true)
        saved_character.available_skill_points = 10
        saved_character.obtain_character_class(character_class)
        expect(saved_character.skills).to include (bcs)
      end
    end
  end

  xdescribe '#add_skill_points' do

  end

  # xdescribe 'class_skills_bonus' do

  # end

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
    it 'removes currently equipped weapon if incompatible (2 non-shields)' do
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

  xdescribe '#equip_armor' do

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
    it 'generates an appropriate attack string without skills' do

    end
    describe 'stat dice effects' do
      it 'adds to the number of dice if the stat die is of the same size as the attack die' do

      end
      it 'adds new dice if the stat die is of a different size to the attack die' do

      end
      it 'adds multiple new dice if strength and dex dice are different (in order of str then dex)' do

      end
    end
  end

  xdescribe '#generate_damage_string' do

  end

  xdescribe '#generate_defense_string' do

  end
end
