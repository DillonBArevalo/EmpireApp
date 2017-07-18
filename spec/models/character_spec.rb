require 'rails_helper'

RSpec.describe Character, type: :model do
  describe 'Associations' do
    let(:user) {User.create({username: 'owner', name: 'tim', email: 'tim@tom.com', password: 'tomtom', password_confirmation: 'tomtom'})}
    let(:character) {user.characters.create(name: 'c', description: 'desc', strength: 11, dexterity: 11, constitution: 11, intelligence: 11, wisdom: 11, charisma: 11, energy_budget_level_bonus: 0, energy_pool_level_bonus: 0, total_skill_points: 100, available_skill_points: 50)}
    let(:character_class) {CharacterClass.create(name: 'class', description: 'a class')}
    let(:weapon_type) {WeaponType.create(name: 'name')}
    let(:weapon) {Weapon.create(user_id: user.id, weapon_type_id: weapon_type.id, name: 'weapon', description: 'a weapon', defense_die_number: 1, defense_die_size: 4, flat_defense_bonus: 1, defense_energy_modifier: 1, extra_attack_cost: 25, extra_block_cost: 25, hands_used: 1)}
    let(:weapon_class) {WeaponClass.create(name: 'weapon class', description: 'a weapon class')}
    let(:damage_type) {DamageType.create(name: 'type1', description: 'a test type')}
    let(:attack_option) {AttackOption.create(name: 'attack_option', description: 'an attack option', weapon_id: weapon.id, strength_dice: 1, dexterity_dice: 1, energy_modifier: 1, die_number: 1, die_size: 4, damage_dice: 1, damage_die_size: 4, strength_damage_bonus: 2, dexterity_damage_bonus: 2, flat_damage_bonus: 1, damage_type_id: damage_type.id)}
    let(:class_skill) {character_class.skills.create(base_class_skill: false, display_description: true,  tactical_maneuver_dex_bonus: false, name: 'skill', description: 'a skill', defense_boost: 2)}
    let(:weapon_skill) {weapon_class.skills.create(base_class_skill: false, display_description: true, tactical_maneuver_dex_bonus: false, name: 'skill', description: 'a skill', damage_boost: 4)}

    describe '#creator' do
      it 'returns the creator of the character' do
        expect(character.creator).to eq(user)
      end
    end

    describe '#character_classes' do
      it 'returns the classes obtained by the character' do
        ObtainedCharacterClass.create(character_id: character.id, character_class_id: character_class.id, invested_points: 20)
        expect(character.character_classes).to eq([character_class])
      end
    end

    describe '#possible_class_skills' do
      it 'returns the skills associated with the character\'s classes' do
        ObtainedCharacterClass.create(character_id: character.id, character_class_id: character_class.id, invested_points: 20)
        expect(character.possible_class_skills).to eq([class_skill])
      end
    end

    describe '#improved_weapon_classes' do
      it 'returns the weapon classes improved by the sills the character has taken' do
        ObtainedSkill.create(applicable_weapon_class_id: weapon_class.id, skill_id: class_skill.id, character_id: character.id)
        expect(character.improved_weapon_classes).to eq([weapon_class])
      end
    end

    describe '#skills' do
      it 'returns the skills the character has obtained' do
        ObtainedSkill.create(skill_id: class_skill.id, character_id: character.id)
        ObtainedSkill.create(skill_id: weapon_skill.id, character_id: character.id)
        expect(character.skills).to eq([class_skill, weapon_skill])
      end
    end

    describe '#inventory' do
      it 'returns the character\'s inventory' do
        inventory = Inventory.create(character_id: character.id)
        expect(character.inventory).to eq(inventory)
      end
    end

    describe '#weapons' do
      it 'returns the weapons in the character\'s inventory' do
        inventory = Inventory.create(character_id: character.id)
        inventory.weapons << weapon
        expect(character.weapons).to eq([weapon])
      end
    end

    describe '#armors' do
      it 'returns the armors in the character\'s inventory' do
        inventory = Inventory.create(character_id: character.id)
        armor_type = ArmorType.create({name: 'armor'})
        armor = Armor.create({user_id: user.id, name: 'armor', armor_type_id: armor_type.id, passive_defense_bonus: 1, active_action_reduction: 1, budget_reduction: 1, dodge_energy_mod_penalty: 0, dodge_die_size_reduction: 0})
        inventory.armors << armor
        expect(character.armors).to eq([armor])
      end
    end

    describe '#equipped_armor' do
      it 'returns the armor the character has equipped' do
        armor_type = ArmorType.create({name: 'armor'})
        armor = Armor.create({user_id: user.id, name: 'armor', armor_type_id: armor_type.id, passive_defense_bonus: 1, active_action_reduction: 1, budget_reduction: 1, dodge_energy_mod_penalty: 0, dodge_die_size_reduction: 0})
        EquippedArmor.create(character_id: character.id, armor_id: armor.id)
        expect(character.equipped_armor).to eq(armor)
      end
    end

    describe '#equipped_weapons' do
      it 'returns the weapons the character has equipped' do
        EquippedWeapon.create(weapon_id: weapon.id, character_id: character.id)
        expect(character.equipped_weapons).to eq([weapon])
      end
    end

    describe '#attack_options' do
      it 'returns the attack options available to the character' do
        EquippedWeapon.create(weapon_id: weapon.id, character_id: character.id)
        expect(character.attack_options).to eq([attack_option])
      end
    end

  end
end
