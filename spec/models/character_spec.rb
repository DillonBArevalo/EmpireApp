require 'rails_helper'

RSpec.describe Character, type: :model do
  describe 'Associations' do
    it{should belong_to :creator}
    it{should have_many :character_classes}
    it{should have_many :possible_class_skills}
    it{should have_many :improved_weapon_classes}
    it{should have_many :displaying_skills}
    it{should have_many :skills}
    it{should have_one :inventory}
    it{should have_many :weapons}
    it{should have_many :armors}
    it{should belong_to :equipped_armor}
    it{should have_many :equipped_weapons}
    it{should have_many :attack_options}
    it{should have_many :class_bcs}
  end

  let(:user) {User.create(username: 'ex', name: 'Tom', email: 'tom@tom.com', password: 'password',password_confirmation: 'password')}
  let(:saved_character) {Character.create(user_id: user.id, name: 'test', description: 'tester', strength: 10, dexterity: 10, constitution: 10)}
  let(:character) {Character.new(name: 'test', description: 'tester', strength: 10, dexterity: 10, constitution: 10)}

  describe 'Extra stats' do
    let(:armor_type) {ArmorType.create(name: 'a-t')}
    let(:armor) {Armor.create(user_id: user.id, armor_type_id: armor_type.id, name: 'Leather Armor', description: 'Thick but flexible and light leather fitted into a suit of armor. Substantially more protective than no armor, but won\'t do much against heavy attacks.', passive_defense_bonus: 10, active_action_reduction: 2, budget_reduction: 2, energy_pool_reduction: 10, dodge_die_size_reduction: 2, dodge_energy_mod_penalty: 0)}

    describe '#active_defense_bonus' do
      it 'returns an integer active_defense_bonus' do
        expect(character.active_defense_bonus.integer?).to be true
        expect(character.active_defense_bonus).to eq(7)
      end

      it 'is debuffed by armor' do
        saved_character.equip_armor(armor)
        expect(saved_character.active_defense_bonus).to eq(5)
      end
    end
    describe '#active_offense_bonus' do
      it 'returns an integer active_offense_bonus' do
        expect(character.active_offense_bonus.integer?).to be true
        expect(character.active_offense_bonus).to eq(10)
      end

      it 'is debuffed by armor' do
        saved_character.equip_armor(armor)
        expect(saved_character.active_offense_bonus).to eq(8)
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

      it 'is debuffed by armor' do
        saved_character.equip_armor(armor)
        expect(saved_character.energy_budget).to eq(12)
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

      it 'is debuffed by armor' do
        saved_character.equip_armor(armor)
        expect(saved_character.energy_pool).to eq(240)
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

    describe '#passive_defense' do
      let(:armor_type) {ArmorType.create(name: 'a-t')}
      let(:armor) {Armor.create(user_id: user.id, armor_type_id: armor_type.id, name: 'Leather Armor', description: 'Thick but flexible and light leather fitted into a suit of armor. Substantially more protective than no armor, but won\'t do much against heavy attacks.', passive_defense_bonus: 10, active_action_reduction: 2, budget_reduction: 2, energy_pool_reduction: 10, dodge_die_size_reduction: 2, dodge_energy_mod_penalty: 0)}
      let(:character_class) {CharacterClass.create(name: 'Ex class', description: 'For testing', motto: 'I help make sure things work!')}
      let(:class_skill) {character_class.skills.create(base_class_skill: false, name: 'tester character class skill', description: 'boosts armor!', ranks_available: 1, passive: true, armor_defense_boost: 5)}
      let!(:class_skill_cost1) {class_skill.skill_costs.create({rank: 1, cost: 10})}

      it 'returns 0 without armor' do
        expect(character.passive_defense).to eq(0)
      end
      it 'returns the passive defense boost with armor' do
        character.equip_armor(armor)
        expect(character.passive_defense).to eq(10)
      end


      it 'benefits from skills that boost passive def' do
        saved_character.equip_armor(armor)
        saved_character.add_skill_points(100)
        saved_character.obtain_character_class(character_class)
        saved_character.obtain_skill(class_skill)
        expect(saved_character.passive_defense).to eq(15)
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
        expect(response[:messages][0]).to eq('You don\'t have enough skill points to obtain the next rank of this skill')
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

      it 'works with weapon skills' do
        response = saved_character.obtain_skill(weapon_skill)
        expect(response[:status]).to be true
        expect(response[:messages]).to eq(["#{saved_character.name} successfully obtained #{weapon_skill.name} at rank 1 for 10 skill points."])
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
        expect(saved_character.obtained_skills.find_by(skill_id: class_skill.id).applicable_weapon_class_id).to eq 1
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
        expect(response[:messages]).to eq(['test does not have enough available skill points (you have 4) to obtain this class (requires 5)'])
      end
      it 'returns status false with an appropriate message you already have the class' do
        saved_character.available_skill_points = 10
        saved_character.obtain_character_class(character_class)
        response = saved_character.obtain_character_class(character_class)
        expect(response[:status]).to be false
        expect(response[:messages]).to eq(['test already has the class Ex class'])
      end
    end

    context 'when you successfully obtain the class' do
      it 'responds with a positive status and a success message' do
        saved_character.available_skill_points = 10
        response = saved_character.obtain_character_class(character_class)
        expect(response[:status]).to be true
        expect(response[:messages]).to eq(['test has obtained the class Ex class and the associated base class skills!'])
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

  describe '#add_skill_points' do
    it 'adds to available skill points' do
      expect{saved_character.add_skill_points(10)}.to change{saved_character.available_skill_points}.from(0).to(10)
    end

    it 'adds to total skill points' do
      expect{saved_character.add_skill_points(10)}.to change{saved_character.total_skill_points}.from(0).to(10)
    end

    it 'adds an appropriate amount of new unspent energy points' do
      expect{saved_character.add_skill_points(10)}.to change{saved_character.unspent_energy_upgrade_points}.from(0).to(2)
    end
  end

  describe '#tactical_maneuver' do
    it 'adds a d20 to the dex score' do
      expect(character.tactical_maneuver).to eq('10 + 1d20')
    end
  end

  describe '#jump' do
    let(:character_class){CharacterClass.create(name: 'class', description: 'desc', motto: 'motto')}
    let(:skill){character_class.skills.create(tactical_maneuver_dex_bonus: true)}
    let!(:rank){skill.skill_costs.create(rank: 1, cost: 1)}
    it 'gives the same number as #tactical_maneuver without the relevant skill' do
      expect(character.jump).to eq(character.tactical_maneuver)
    end

    it 'adds a dex die with the relevant skill' do
      saved_character.add_skill_points(50)
      saved_character.obtain_character_class(character_class)
      saved_character.obtain_skill(skill)
      expect(saved_character.jump).to eq(character.tactical_maneuver + ' + 1d4')
    end
  end

  describe 'equipping' do
    let(:shields) {WeaponClass.new(name: 'Shields')}
    let(:shield) {Weapon.new(name: 'Light Shield', description: 'desc', defense_die_number: 1, defense_die_size: 10, flat_defense_bonus: 4, defense_energy_modifier: 2, extra_block_cost: 30, hands_used: 1)}
    let(:shield2) {Weapon.new(name: 'heavy Shield', description: 'desc', defense_die_number: 4, defense_die_size: 4, flat_defense_bonus: 4, defense_energy_modifier: 2, extra_block_cost: 30, hands_used: 1)}
    let(:b_axe) {Weapon.new(name: 'Battle Axe', description: 'desc', defense_die_number: 1, defense_die_size: 10, flat_defense_bonus: 5, defense_energy_modifier: 1, extra_block_cost: 30, extra_attack_cost: 30, hands_used: 2, dodge_energy_mod_penalty: 0.5)}
    let(:h_axe) {Weapon.new(name: 'Hand Axe', description: 'desc', defense_die_number: 1, defense_die_size: 6, flat_defense_bonus: 5, defense_energy_modifier: 0.5, extra_block_cost: 25, extra_attack_cost: 25, hands_used: 1)}

    describe '#remove_weapon' do
      it 'removes a character\'s equipped weapon if no parameter is passed' do
        character.equip_weapon(b_axe)
        expect(character.equipped_weapons).to include(b_axe)
        character.remove_weapon
        expect(character.equipped_weapons).to be_empty
      end

      it 'removes a character\'s equipped shield if true is passed' do
        shield.weapon_classes << shields
        character.equip_weapon(shield)
        expect(character.equipped_weapons).to include(shield)
        character.remove_weapon(true)
        expect(character.equipped_weapons).to be_empty
      end
    end

    describe '#equip_weapon' do
      it 'returns false if weapon could not be equipped (not enough hands)' do
        shield.weapon_classes << shields
        character.equip_shield(shield)
        expect(character.equip_weapon(b_axe)).to be false
      end
      it 'adds an equipped weapon to character.equipped_weapons' do
        character.equip_weapon(b_axe)
        expect(character.equipped_weapons).to include(b_axe)
      end
      it 'removes currently equipped weapon if incompatible (2 non-shields)' do
        character.equip_weapon(b_axe)
        character.equip_weapon(h_axe)
        expect(character.equipped_weapons).to include(h_axe)
        expect(character.equipped_weapons.length).to eq(1)
      end
    end

    describe '#equip_shield' do
        before(:each){shield.weapon_classes << shields}
      it 'returns false if shield could not be equipped (not enough hands)' do
        character.equip_weapon(b_axe)
        expect(character.equip_shield(shield)).to be false
      end
      it 'adds an equipped shield to character.equipped_weapons' do
        character.equip_shield(shield)
        expect(character.equipped_weapons).to include(shield)
      end
      it 'removes currently equipped shield if it exists' do
        character.equip_shield(shield)
        character.equip_shield(shield2)
        expect(character.equipped_weapons).to include(shield2)
        expect(character.equipped_weapons.length).to eq(1)
      end
    end

    describe 'equipping armor' do
      let(:armor_type) {ArmorType.create(name: 'a-t')}
      let(:armor) {Armor.create(user_id: user.id, armor_type_id: armor_type.id, name: 'Leather Armor', description: 'Thick but flexible and light leather fitted into a suit of armor. Substantially more protective than no armor, but won\'t do much against heavy attacks.', passive_defense_bonus: 10, active_action_reduction: 2, budget_reduction: 2, energy_pool_reduction: 10, dodge_die_size_reduction: 2, dodge_energy_mod_penalty: 0)}
      let(:armor2) {Armor.create(user_id: user.id, armor_type_id: armor_type.id, name: 'Padded Armor', description: 'Thick cloth formed into a gambeson. Substantially more protective than no armor, but won\'t do much against heavy attacks.', passive_defense_bonus: 10, active_action_reduction: 2, budget_reduction: 2, energy_pool_reduction: 10, dodge_die_size_reduction: 2, dodge_energy_mod_penalty: 0)}
      describe '#remove_armor' do
        it 'removes armor' do
          saved_character.equip_armor(armor)
          expect(saved_character.equipped_armor).to eq armor
          saved_character.remove_armor
          expect(saved_character.equipped_armor).to be nil
        end
      end

      describe '#equip_armor' do
        it 'sets a given armor to be that characters equipped armor' do
          saved_character.equip_armor(armor)
          expect(saved_character.equipped_armor).to eq armor
        end

        it 'removes the armor the user was previously wearing' do
          saved_character.equip_armor(armor)
          saved_character.remove_armor
          saved_character.equip_armor(armor2)
          expect(saved_character.equipped_armor).not_to eq armor
        end
      end
    end
  end

  describe '#free_hands' do
    it 'returns the number of free hands a character has' do
      expect(character.free_hands).to eq(2)

      shield = Weapon.new(hands_used: 1)
      character.equipped_weapons << shield
      expect(character.free_hands).to eq(1)

      h_axe = Weapon.new(name: 'Hand Axe', description: 'A small axe', defense_die_number: 1, defense_die_size: 6, flat_defense_bonus: 5, defense_energy_modifier: 0.5, extra_block_cost: 25, extra_attack_cost: 25, hands_used: 1)
      character.equipped_weapons << h_axe
      expect(character.free_hands).to eq(0)
    end
  end

  describe '#generate_attack_string' do

    let(:axe) {WeaponType.create(name: 'Axe')}
    let(:hand_axe)  {Weapon.create(user_id: user.id, weapon_type_id: axe.id, name: 'Hand Axe', description: "A small, one handed axe that can strike with precision and efficiency. Its head heavy nature make its chops surprisingly powerful.", defense_die_number: 1, defense_die_size: 6, flat_defense_bonus: 5, defense_energy_modifier: 0.5, extra_block_cost: 25, extra_attack_cost: 25, hands_used: 1)}
    let(:class2) {WeaponClass.create(name: "Finesse Weapons", description: "Type 2 weapons are one handed weapons that can be wielded by themselves, with another weapon (not yet), or with a shield. These weapons are often difficult to use initially but scale very well when skill points are sunk into them. They scale off of either dexterity and strength, or one of the two. Class 2 weapons have low damage and low attack numbers initially (though they usually have fairly high defensive numbers) but can scale the attack extremely well and damage numbers fairly well. What they lack in early game strength they make up for in both late game strength and the defensive capabilities (especially when coupled with a shield) to get you there.")}
    let(:attack_option)  {AttackOption.new(name: 'Chop', weapon_id: hand_axe.id, strength_dice: 1, dexterity_dice: 1, energy_modifier: 2, die_number: 1, die_size: 10, damage_dice: 1, damage_die_size: 6, strength_damage_bonus: 4, dexterity_damage_bonus: 6, flat_damage_bonus: 8)}
    let(:armor_type) {ArmorType.create(name: 'a-t')}
    let(:armor) {Armor.create(user_id: user.id, armor_type_id: armor_type.id, name: 'Leather Armor', description: 'Thick but flexible and light leather fitted into a suit of armor. Substantially more protective than no armor, but won\'t do much against heavy attacks.', passive_defense_bonus: 10, active_action_reduction: 2, budget_reduction: 2, energy_pool_reduction: 10, dodge_die_size_reduction: 2, dodge_energy_mod_penalty: 0)}

    before(:each) do
      WeaponClassesWeapon.create(weapon_class_id: class2.id, weapon_id: hand_axe.id)
      saved_character.equip_weapon(hand_axe)
    end

    it 'generates an appropriate attack string without skills' do
      expect(saved_character.generate_attack_string(attack_option)).to eq('2.0 x Energy Input + 10 + 2d4 + 1d10')
    end

    it 'is affected by armor' do
      saved_character.equip_armor(armor)
      expect(saved_character.generate_attack_string(attack_option)).to eq('2.0 x Energy Input + 8 + 2d4 + 1d10')

    end

    describe 'stat dice effects' do

      it 'adds to the number of dice if the stat die is of the same size as the attack die' do
        attack_option.die_size = 4
        expect(saved_character.generate_attack_string(attack_option)).to eq('2.0 x Energy Input + 10 + 3d4')
      end

      it 'adds new dice if the stat die is of a different size to the attack die' do
        attack_option.strength_dice = 0
        expect(saved_character.generate_attack_string(attack_option)).to eq('2.0 x Energy Input + 10 + 1d4 + 1d10')
      end

      it 'adds multiple new dice if strength and dex dice are different (in order of str then dex)' do
        saved_character.strength = 16
        expect(saved_character.generate_attack_string(attack_option)).to eq('2.0 x Energy Input + 13 + 1d8 + 1d4 + 1d10')
      end

    end

    describe 'skill bonuses' do

      let(:character_class) {CharacterClass.create(name: 'Ex class', description: 'For testing!', motto: 'I help make sure things work!')}
      let(:class_skill) {character_class.skills.create(base_class_skill: false, name: 'tester character class skill', description: 'a skill for testing!', is_weapon_boost: true, weapon_class: class2.id, ranks_available: 2, passive: true, accuracy_boost: 5)}
      let!(:class_skill_cost1) {class_skill.skill_costs.create({rank: 1, cost: 10})}
      let!(:class_skill_cost2) {class_skill.skill_costs.create({rank: 2, cost: 4})}

      before(:each) do
        saved_character.add_skill_points(100)
        saved_character.obtain_character_class(character_class)
        saved_character.obtain_skill(class_skill)
      end

      it 'won\'t affect an attack done by a weapon of the wrong class' do
        saved_character.obtained_skills.find_by(skill_id: class_skill.id).update(applicable_weapon_class_id: 0)
        class_skill.update(weapon_class: 0)
        expect(saved_character.generate_attack_string(attack_option)).to eq('2.0 x Energy Input + 10 + 2d4 + 1d10')
      end

      it 'will affect an attack done by a weapon it is specifically targeting' do
        expect(saved_character.generate_attack_string(attack_option)).to eq('2.0 x Energy Input + 15 + 2d4 + 1d10')
      end

      it 'will affect an attack done by a weapon if the skill doesn\'t target any weapon class' do
        saved_character.obtained_skills.find_by(skill_id: class_skill.id).update(applicable_weapon_class_id: nil)
        class_skill.update(weapon_class: nil, is_weapon_boost: false)
        expect(saved_character.generate_attack_string(attack_option)).to eq('2.0 x Energy Input + 15 + 2d4 + 1d10')
      end

      it 'boosts base attack' do
        expect(saved_character.generate_attack_string(attack_option)).to eq('2.0 x Energy Input + 15 + 2d4 + 1d10')
      end

      it 'boosts energy modifiers (currently only for a shield bash, but should work with any weapon if there is a skill for it)' do
        class_skill.update(accuracy_boost: 0, attack_energy_mod_boost: 1.2)
        expect(saved_character.generate_attack_string(attack_option)).to eq('3.2 x Energy Input + 10 + 2d4 + 1d10')
      end

      it 'multiplies bonuses by rank' do
        saved_character.obtain_skill(class_skill)
        expect(saved_character.generate_attack_string(attack_option)).to eq('2.0 x Energy Input + 20 + 2d4 + 1d10')
      end

    end
  end

  describe '#generate_damage_string' do
    let(:axe) {WeaponType.create(name: 'Axe')}
    let(:hand_axe)  {Weapon.create(user_id: user.id, weapon_type_id: axe.id, name: 'Hand Axe', description: "A small, one handed axe that can strike with precision and efficiency. Its head heavy nature make its chops surprisingly powerful.", defense_die_number: 1, defense_die_size: 6, flat_defense_bonus: 5, defense_energy_modifier: 0.5, extra_block_cost: 25, extra_attack_cost: 25, hands_used: 1)}
    let(:damage_type) {DamageType.create(name: 'slashing', description: 'slaaaash')}
    let(:attack_option)  {AttackOption.new(name: 'Chop', damage_type_id: damage_type.id, weapon_id: hand_axe.id, strength_dice: 1, dexterity_dice: 1, energy_modifier: 2, die_number: 1, die_size: 10, damage_dice: 1, damage_die_size: 6, strength_damage_bonus: 4, dexterity_damage_bonus: 6, flat_damage_bonus: 8)}
    let(:class2) {WeaponClass.create(name: "Finesse Weapons", description: "Type 2 weapons are one handed weapons that can be wielded by themselves, with another weapon (not yet), or with a shield. These weapons are often difficult to use initially but scale very well when skill points are sunk into them. They scale off of either dexterity and strength, or one of the two. Class 2 weapons have low damage and low attack numbers initially (though they usually have fairly high defensive numbers) but can scale the attack extremely well and damage numbers fairly well. What they lack in early game strength they make up for in both late game strength and the defensive capabilities (especially when coupled with a shield) to get you there.")}

    before(:each) do
      WeaponClassesWeapon.create(weapon_class_id: class2.id, weapon_id: hand_axe.id)
      saved_character.equip_weapon(hand_axe)
    end

    it 'generates an appropriate damage string without skills' do
      expect(saved_character.generate_damage_string(attack_option)).to eq('13 + 1d6 slashing')
    end

    describe 'stat effects' do

      it 'changes based on strength or dex' do
        saved_character.strength = 13
        expect(saved_character.generate_damage_string(attack_option)).to eq('14 + 1d6 slashing')
      end

      it 'won\'t change if the divisor is nil' do
        attack_option.strength_damage_bonus = nil
        expect(saved_character.generate_damage_string(attack_option)).to eq('10 + 1d6 slashing')
      end
    end

    describe 'skill bonuses' do

      let(:character_class) {CharacterClass.create(name: 'Ex class', description: 'For testing!', motto: 'I help make sure things work!')}
      let(:class_skill) {character_class.skills.create(base_class_skill: false, name: 'tester character class skill', description: 'a skill for testing!', is_weapon_boost: true, weapon_class: class2.id, ranks_available: 2, passive: true, damage_boost: 5)}
      let!(:class_skill_cost1) {class_skill.skill_costs.create({rank: 1, cost: 10})}
      let!(:class_skill_cost2) {class_skill.skill_costs.create({rank: 2, cost: 4})}

      before(:each) do
        saved_character.add_skill_points(100)
        saved_character.obtain_character_class(character_class)
        saved_character.obtain_skill(class_skill)
      end

      it 'won\'t affect a damage done by a weapon of the wrong class' do
        saved_character.obtained_skills.find_by(skill_id: class_skill.id).update(applicable_weapon_class_id: 0)
        class_skill.update(weapon_class: 0)
        expect(saved_character.generate_damage_string(attack_option)).to eq('13 + 1d6 slashing')
      end

      it 'will affect an attack done by a weapon it is specifically targeting' do
        expect(saved_character.generate_damage_string(attack_option)).to eq('18 + 1d6 slashing')
      end

      it 'will affect a damage done by a weapon if the skill doesn\'t target any weapon class' do
        saved_character.obtained_skills.find_by(skill_id: class_skill.id).update(applicable_weapon_class_id: nil)
        class_skill.update(weapon_class: nil, is_weapon_boost: false)
        expect(saved_character.generate_damage_string(attack_option)).to eq('18 + 1d6 slashing')
      end

      it 'boosts base damage' do
        expect(saved_character.generate_damage_string(attack_option)).to eq('18 + 1d6 slashing')
      end

      it 'boosts die size for damage' do
        class_skill.update(damage_boost: 0, damage_die_boost: 2)
        expect(saved_character.generate_damage_string(attack_option)).to eq('13 + 1d8 slashing')
      end

      it 'multiplies bonuses by rank' do
        saved_character.obtain_skill(class_skill)
        expect(saved_character.generate_damage_string(attack_option)).to eq('23 + 1d6 slashing')
      end

    end
  end

  describe '#generate_defense_string' do
    let(:axe) {WeaponType.create(name: 'Axe')}
    let(:hand_axe)  {Weapon.create(user_id: user.id, weapon_type_id: axe.id, name: 'Hand Axe', description: "A small, one handed axe that can strike with precision and efficiency. Its head heavy nature make its chops surprisingly powerful.", defense_die_number: 1, defense_die_size: 6, flat_defense_bonus: 5, defense_energy_modifier: 0.5, extra_block_cost: 25, extra_attack_cost: 25, hands_used: 1)}
    let(:class2) {WeaponClass.create(name: "Finesse Weapons", description: "Type 2 weapons are one handed weapons that can be wielded by themselves, with another weapon (not yet), or with a shield. These weapons are often difficult to use initially but scale very well when skill points are sunk into them. They scale off of either dexterity and strength, or one of the two. Class 2 weapons have low damage and low attack numbers initially (though they usually have fairly high defensive numbers) but can scale the attack extremely well and damage numbers fairly well. What they lack in early game strength they make up for in both late game strength and the defensive capabilities (especially when coupled with a shield) to get you there.")}
    let(:armor_type) {ArmorType.create(name: 'a-t')}
    let(:armor) {Armor.create(user_id: user.id, armor_type_id: armor_type.id, name: 'Leather Armor', description: 'Thick but flexible and light leather fitted into a suit of armor. Substantially more protective than no armor, but won\'t do much against heavy attacks.', passive_defense_bonus: 10, active_action_reduction: 2, budget_reduction: 2, energy_pool_reduction: 10, dodge_die_size_reduction: 2, dodge_energy_mod_penalty: 0)}

    before(:each) do
      WeaponClassesWeapon.create(weapon_class_id: class2.id, weapon_id: hand_axe.id)
      saved_character.equip_weapon(hand_axe)
    end

    it 'generates an appropriate defense string without skills' do
      expect(saved_character.generate_defense_string(hand_axe)).to eq('0.5 x Energy Input + 12 + 1d4 + 1d6 (+ passive defense (0) if block fails)')
    end

    it 'is affected by armor (reduction in flat and added passive)' do
      saved_character.equip_armor(armor)
      expect(saved_character.generate_defense_string(hand_axe)).to eq('0.5 x Energy Input + 10 + 1d4 + 1d6 (+ passive defense (10) if block fails)')
    end

    describe 'stat dice effects' do

      it 'adds to the number of dice if the stat die is of the same size as the attack die' do
        saved_character.constitution = 12
        expect(saved_character.generate_defense_string(hand_axe)).to eq('0.5 x Energy Input + 13 + 2d6 (+ passive defense (0) if block fails)')
      end

      it 'adds new dice if the stat die is of a different size to the attack die' do
        saved_character.constitution = 16
        expect(saved_character.generate_defense_string(hand_axe)).to eq('0.5 x Energy Input + 15 + 1d8 + 1d6 (+ passive defense (0) if block fails)')
      end
    end

    describe 'skill bonuses' do

      let(:character_class) {CharacterClass.create(name: 'Ex class', description: 'For testing!', motto: 'I help make sure things work!')}
      let(:class_skill) {character_class.skills.create(base_class_skill: false, name: 'tester character class skill', description: 'a skill for testing!', is_weapon_boost: true, weapon_class: class2.id, ranks_available: 2, passive: true, defense_boost: 5)}
      let!(:class_skill_cost1) {class_skill.skill_costs.create({rank: 1, cost: 10})}
      let!(:class_skill_cost2) {class_skill.skill_costs.create({rank: 2, cost: 4})}

      before(:each) do
        saved_character.add_skill_points(100)
        saved_character.obtain_character_class(character_class)
        saved_character.obtain_skill(class_skill)
      end

      it 'won\'t affect a defense done by a weapon of the wrong class' do
        saved_character.obtained_skills.find_by(skill_id: class_skill.id).update(applicable_weapon_class_id: 0)
        class_skill.update(weapon_class: 0)
        expect(saved_character.generate_defense_string(hand_axe)).to eq('0.5 x Energy Input + 12 + 1d4 + 1d6 (+ passive defense (0) if block fails)')
      end

      it 'will affect a block done by a weapon it is specifically targeting' do
        expect(saved_character.generate_defense_string(hand_axe)).to eq('0.5 x Energy Input + 17 + 1d4 + 1d6 (+ passive defense (0) if block fails)')
      end

      it 'will affect a defense done by a weapon if the skill doesn\'t target any weapon class' do
        saved_character.obtained_skills.find_by(skill_id: class_skill.id).update(applicable_weapon_class_id: nil)
        class_skill.update(weapon_class: nil, is_weapon_boost: false)
        expect(saved_character.generate_defense_string(hand_axe)).to eq('0.5 x Energy Input + 17 + 1d4 + 1d6 (+ passive defense (0) if block fails)')
      end

      it 'boosts base defense' do
        expect(saved_character.generate_defense_string(hand_axe)).to eq('0.5 x Energy Input + 17 + 1d4 + 1d6 (+ passive defense (0) if block fails)')
      end

      it 'boosts die size for a block' do
        class_skill.update(defense_boost: 0, defense_die_boost: 2)
        expect(saved_character.generate_defense_string(hand_axe)).to eq('0.5 x Energy Input + 12 + 1d4 + 1d8 (+ passive defense (0) if block fails)')
      end

      it 'multiplies bonuses by rank' do
        saved_character.obtain_skill(class_skill)
        expect(saved_character.generate_defense_string(hand_axe)).to eq('0.5 x Energy Input + 22 + 1d4 + 1d6 (+ passive defense (0) if block fails)')
      end

    end
  end


  describe 'multi_attack_numbers_and_cost' do
    let(:axe) {WeaponType.create(name: 'Axe')}
    let(:hand_axe)  {Weapon.create(user_id: user.id, weapon_type_id: axe.id, name: 'Hand Axe', description: "A small, one handed axe that can strike with precision and efficiency. Its head heavy nature make its chops surprisingly powerful.", defense_die_number: 1, defense_die_size: 6, flat_defense_bonus: 5, defense_energy_modifier: 0.5, extra_block_cost: 25, extra_attack_cost: 25, hands_used: 1)}

    context 'without skills' do
      it 'prints the default message' do
        expect(character.multi_attack_numbers_and_cost(hand_axe)).to eq('1')
      end
    end

    context 'with skills' do
      let(:character_class) {CharacterClass.create(name: 'Ex class', description: 'For testing!', motto: 'I help make sure things work!')}
      let(:class_skill) {character_class.skills.create(base_class_skill: false, name: 'tester character class skill', description: 'a skill for testing!', ranks_available: 2, passive: true, bonus_attacks: 1)}
      let!(:class_skill_cost1) {class_skill.skill_costs.create({rank: 1, cost: 10})}

      before(:each) do
        saved_character.add_skill_points(100)
        saved_character.obtain_character_class(character_class)
        saved_character.obtain_skill(class_skill)
      end

      it 'can add extra attacks with the right skills' do
        expect(saved_character.multi_attack_numbers_and_cost(hand_axe)).to eq('1 + 1 at the cost of 4 energy each')
      end

      it 'will modify extra attack cost based on max energy budget (by stats)' do
        saved_character.update(strength: 18, dexterity: 18, energy_budget_level_bonus: 10)
        expect(saved_character.multi_attack_numbers_and_cost(hand_axe)).to eq('1 + 1 at the cost of 10 energy each')
      end

      it 'can make those attacks cheaper' do
        class_skill.update(attack_cost_reduction: 15)
        expect(saved_character.multi_attack_numbers_and_cost(hand_axe)).to eq('1 + 1 at the cost of 2 energy each')
      end
    end
  end

  describe '#total_blocks' do
    let(:axe) {WeaponType.create(name: 'Axe')}
    let(:shield_type) {WeaponType.create(name: 'shield')}
    let(:hand_axe)  {Weapon.create(user_id: user.id, weapon_type_id: axe.id, name: 'Hand Axe', description: "A small, one handed axe that can strike with precision and efficiency. Its head heavy nature make its chops surprisingly powerful.", defense_die_number: 1, defense_die_size: 6, flat_defense_bonus: 5, defense_energy_modifier: 0.5, extra_block_cost: 25, extra_attack_cost: 25, hands_used: 1)}
    let(:shields) {WeaponClass.create(name: 'Shields')}
    let(:shield) {Weapon.create(user_id: user.id, weapon_type_id: shield_type.id, name: 'Light Shield', description: 'desc', defense_die_number: 1, defense_die_size: 10, flat_defense_bonus: 4, defense_energy_modifier: 2, extra_block_cost: 30, hands_used: 1)}
    let(:class2) {WeaponClass.create(name: "Finesse Weapons", description: "Type 2 weapons are one handed weapons that can be wielded by themselves, with another weapon (not yet), or with a shield. These weapons are often difficult to use initially but scale very well when skill points are sunk into them. They scale off of either dexterity and strength, or one of the two. Class 2 weapons have low damage and low attack numbers initially (though they usually have fairly high defensive numbers) but can scale the attack extremely well and damage numbers fairly well. What they lack in early game strength they make up for in both late game strength and the defensive capabilities (especially when coupled with a shield) to get you there.")}
    let(:character_class) {CharacterClass.create(name: 'Ex class', description: 'For testing!', motto: 'I help make sure things work!')}
    let(:class_skill) {character_class.skills.create(base_class_skill: false, name: 'tester character class skill', description: 'a skill for testing!', is_weapon_boost: true, weapon_class: class2.id, ranks_available: 2, passive: true, bonus_blocks: 1)}
    let!(:class_skill_cost1) {class_skill.skill_costs.create({rank: 1, cost: 10})}
    let(:class_skill2) {character_class.skills.create(base_class_skill: false, name: 'tester character class skill', description: 'a skill for testing!', is_weapon_boost: true, weapon_class: shields.id, ranks_available: 2, passive: true, bonus_blocks: 1)}
    let!(:class_skill2_cost1) {class_skill2.skill_costs.create({rank: 1, cost: 10})}

    before(:each) do
      WeaponClassesWeapon.create(weapon_class_id: class2.id, weapon_id: hand_axe.id)
      WeaponClassesWeapon.create(weapon_class_id: shields.id, weapon_id: shield.id)
    end

    it 'returns the number of weapons you have equipped + panic' do
      expect(character.total_blocks).to eq('0 + 0 panic block(s) for half your next offense budget')
      character.equip_weapon(hand_axe)
      expect(character.total_blocks).to eq('1 + 1 panic block(s) for half your next offense budget')
      character.equip_shield(shield)
      expect(character.total_blocks).to eq('2 + 2 panic block(s) for half your next offense budget')
    end

    it 'is affected by skills on either equipped weapon' do
      saved_character.equip_weapon(hand_axe)
      saved_character.equip_shield(shield)
      saved_character.add_skill_points(100)
      saved_character.obtain_character_class(character_class)
      saved_character.obtain_skill(class_skill)
      saved_character.obtain_skill(class_skill2)
      expect(saved_character.total_blocks).to eq('4 + 2 panic block(s) for half your next offense budget')
    end
  end

  describe '#multi_block_numbers_and_cost' do
    let(:axe) {WeaponType.create(name: 'Axe')}
    let(:hand_axe)  {Weapon.create(user_id: user.id, weapon_type_id: axe.id, name: 'Hand Axe', description: "A small, one handed axe that can strike with precision and efficiency. Its head heavy nature make its chops surprisingly powerful.", defense_die_number: 1, defense_die_size: 6, flat_defense_bonus: 5, defense_energy_modifier: 0.5, extra_block_cost: 25, extra_attack_cost: 25, hands_used: 1)}

    context 'without skills' do
      it 'prints the default message' do
        expect(character.multi_block_numbers_and_cost(hand_axe)).to eq('1 + 1 panic at the cost of half your next offense budget')
      end
    end

    context 'with skills' do
      let(:character_class) {CharacterClass.create(name: 'Ex class', description: 'For testing!', motto: 'I help make sure things work!')}
      let(:class_skill) {character_class.skills.create(base_class_skill: false, name: 'tester character class skill', description: 'a skill for testing!', ranks_available: 2, passive: true, bonus_blocks: 1)}
      let!(:class_skill_cost1) {class_skill.skill_costs.create({rank: 1, cost: 10})}

      before(:each) do
        saved_character.add_skill_points(100)
        saved_character.obtain_character_class(character_class)
        saved_character.obtain_skill(class_skill)
      end

      it 'can add extra blocks with the right skills' do
        expect(saved_character.multi_block_numbers_and_cost(hand_axe)).to eq('1 + 1 at the cost of 4 energy each + 1 panic at the cost of half your next offense budget')
      end

      it 'will modify extra block cost based on max energy budget (by stats)' do
        saved_character.update(strength: 18, dexterity: 18, energy_budget_level_bonus: 10)
        expect(saved_character.multi_block_numbers_and_cost(hand_axe)).to eq('1 + 1 at the cost of 10 energy each + 1 panic at the cost of half your next offense budget')
      end

      it 'can make those blocks cheaper' do
        class_skill.update(defense_cost_reduction: 15)
        expect(saved_character.multi_block_numbers_and_cost(hand_axe)).to eq('1 + 1 at the cost of 2 energy each + 1 panic at the cost of half your next offense budget')
      end
    end
  end

  describe '#dodge_numbers' do
    let(:axe) {WeaponType.create(name: 'Axe')}
    let(:hand_axe)  {Weapon.create(user_id: user.id, weapon_type_id: axe.id, name: 'Hand Axe', description: "A small, one handed axe that can strike with precision and efficiency. Its head heavy nature make its chops surprisingly powerful.", defense_die_number: 1, defense_die_size: 6, flat_defense_bonus: 5, defense_energy_modifier: 0.5, extra_block_cost: 25, extra_attack_cost: 25, hands_used: 1, dodge_energy_mod_penalty: 0.5)}
    let(:armor_type) {ArmorType.create(name: 'a-t')}
    let(:armor) {Armor.create(user_id: user.id, armor_type_id: armor_type.id, name: 'Leather Armor', description: 'Thick but flexible and light leather fitted into a suit of armor. Substantially more protective than no armor, but won\'t do much against heavy attacks.', passive_defense_bonus: 10, active_action_reduction: 2, budget_reduction: 2, energy_pool_reduction: 10, dodge_die_size_reduction: 2, dodge_energy_mod_penalty: 0.5)}

    it 'generates an appropriate dodge string without skills or armor' do
      expect(character.dodge_numbers).to eq('2 x Energy Input + 12 + 1d4 + 1d10')
    end

    it 'is reduced by armor' do
      saved_character.equip_armor(armor)
      expect(saved_character.dodge_numbers).to eq('1.5 x Energy Input + 10 + 1d4 + 1d8')
    end

    it 'is reduced by weapons' do
      saved_character.equip_weapon(hand_axe)
      expect(saved_character.dodge_numbers).to eq('1.5 x Energy Input + 12 + 1d4 + 1d10')
    end
  end

  describe '#possible_skills' do
    let(:weapon_class) {WeaponClass.create(name: 'weapon class', description: 'a weapon class!')}
    let!(:weapon_skill) {weapon_class.skills.create(name: 'tester weapon skill', description: 'a weapon skill for testing!', ranks_available: 2, passive: true, accuracy_boost: 5)}
    let(:character_class) {CharacterClass.create(name: 'Ex class', description: 'For testing', motto: 'I help make sure things work!')}
    let!(:class_skill) {character_class.skills.create(base_class_skill: false, name: 'tester character class skill', description: 'boosts armor!', ranks_available: 1, passive: true, armor_defense_boost: 5)}

    it 'lists all weapon skills and all class skills of a class the character has' do
      saved_character.add_skill_points(100)
      saved_character.obtain_character_class(character_class)
      expect(saved_character.possible_skills).to eq([weapon_skill, class_skill])
    end

    it 'rejects class skills the character doesn\'t have' do
      expect(character.possible_skills).to eq([weapon_skill])
    end
  end
end
