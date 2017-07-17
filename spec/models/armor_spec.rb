require 'rails_helper'

RSpec.describe Armor, type: :model do
  describe 'Associations' do
  let(:armor_creator) { User.create({username: 'creator', name: 'tom', email: 'tom@tom.com', password: 'tomtom', password_confirmation: 'tomtom'}) }
  let(:armor_type) { ArmorType.create({name: 'armor'})}
  let(:armor) { Armor.create({user_id: armor_creator.id, name: 'armor', armor_type_id: armor_type.id, passive_defense_bonus: 1, active_action_reduction: 1, budget_reduction: 1, dodge_energy_mod_penalty: 0, dodge_die_size_reduction: 0}) }
  let(:user) {User.create({username: 'owner', name: 'tim', email: 'tim@tom.com', password: 'tomtom', password_confirmation: 'tomtom'})}
  let(:character) {user.characters.create(name: 'c', description: 'desc', strength: 11, dexterity: 11, constitution: 11, intelligence: 11, wisdom: 11, charisma: 11, energy_budget_level_bonus: 0, energy_pool_level_bonus: 0, total_skill_points: 0, available_skill_points: 0)}
    describe '#creator' do
      it 'returns the user that created the armor' do
        expect(armor.creator).to eq(armor_creator)
      end
    end
    describe '#armor_type' do
      it 'returns the armor type of the armor' do
        expect(armor.armor_type).to eq(armor_type)
      end
    end
    describe '#damage_resistances' do
      it 'returns the damage resistances of the armor' do
        type = DamageType.create(name: 'type1', description: 'a test type')
        dr = DamageResistance.create(armor_id: armor.id, damage_type_id: type.id, amount: 12)
        expect(armor.damage_resistances).to eq([dr])
      end
    end
    describe '#characters' do
      it 'returns the characters that have the armor equipped' do
        EquippedArmor.create(character_id: character.id, armor_id: armor.id)
        expect(armor.characters).to eq([character])
      end
    end
    #refactor to not use let so i can use another describe block.
    describe '#inventories' do
      it 'returns the inventories that contain this armor' do
        #maybe refactor this to a new describe with a let?
        inventory = Inventory.create(character_id: character.id)
        ObtainedArmor.create(inventory_id: inventory.id, armor_id: armor.id)
        expect(armor.inventories).to eq([inventory])
      end
    end
    describe '#owners' do
      it 'returns the characters that have armor in their inventories' do
        inventory = Inventory.create(character_id: character.id)
        ObtainedArmor.create(inventory_id: inventory.id, armor_id: armor.id)
        expect(armor.owners).to eq([character])
      end
    end
    describe '#users' do
      it 'returns the users that have characters that own the armor' do
        inventory = Inventory.create(character_id: character.id)
        ObtainedArmor.create(inventory_id: inventory.id, armor_id: armor.id)
        expect(armor.owners).to eq([character])
      end
    end
  end
end
