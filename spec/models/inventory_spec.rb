require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe 'Associations' do
    it { should belong_to :character}
    it { should have_many :obtained_weapons}
    it { should have_many :weapons}
    it { should have_many :obtained_armors}
    it { should have_many :armors}
  end

  describe 'Zipping joins to items' do
    let(:user) {User.create!(username: 'ex', name: 'Tom', email: 'tom@tom.com', password: 'password',password_confirmation: 'password')}
    let(:character) {Character.create!(user_id: user.id, name: 'test', description: 'tester', strength: 10, dexterity: 10, constitution: 10)}

    let(:inventory) {Inventory.create!(character_id: character.id)}
    let(:axe) {WeaponType.create(name: 'Axe')}
    let(:weapon1) {Weapon.create(user_id: user.id, weapon_type_id: axe.id, name: 'Hand Axe', description: "A small, one handed axe that can strike with precision and efficiency. Its head heavy nature make its chops surprisingly powerful.", defense_die_number: 1, defense_die_size: 6, flat_defense_bonus: 5, defense_energy_modifier: 0.5, extra_block_cost: 25, extra_attack_cost: 25, hands_used: 1)}
    let(:weapon2) {Weapon.create(user_id: user.id, weapon_type_id: axe.id, name: 'not Hand Axe', description: "A small, one handed axe that can strike with precision and efficiency. Its head heavy nature make its chops surprisingly powerful.", defense_die_number: 1, defense_die_size: 6, flat_defense_bonus: 5, defense_energy_modifier: 0.5, extra_block_cost: 25, extra_attack_cost: 25, hands_used: 1)}
    let(:armor_type) {ArmorType.create(name: 'a-t')}
    let(:armor1) {Armor.create(user_id: user.id, armor_type_id: armor_type.id, name: 'Leather Armor', description: 'Thick but flexible and light leather fitted into a suit of armor. Substantially more protective than no armor, but won\'t do much against heavy attacks.', passive_defense_bonus: 10, active_action_reduction: 2, budget_reduction: 2, energy_pool_reduction: 10, dodge_die_size_reduction: 2, dodge_energy_mod_penalty: 0)}
    let(:armor2) {Armor.create(user_id: user.id, armor_type_id: armor_type.id, name: 'not Leather Armor', description: 'Thick but flexible and light leather fitted into a suit of armor. Substantially more protective than no armor, but won\'t do much against heavy attacks.', passive_defense_bonus: 10, active_action_reduction: 2, budget_reduction: 2, energy_pool_reduction: 10, dodge_die_size_reduction: 2, dodge_energy_mod_penalty: 0)}

    describe '#weapons_and_joins' do
      it 'wraps up weapons with their joins in a nested array' do
        ow1 = ObtainedWeapon.create(weapon_id: weapon2.id, inventory_id: inventory.id)
        ow2 = ObtainedWeapon.create(weapon_id: weapon1.id, inventory_id: inventory.id)
        expect(inventory.weapons_and_joins).to eq([[weapon2, ow1], [weapon1, ow2]])
      end
    end

    describe '#weapons_and_joins' do
      it 'wraps up armors with their joins in a nested array' do
        oa1 = ObtainedArmor.create(armor_id: armor2.id, inventory_id: inventory.id)
        oa2 = ObtainedArmor.create(armor_id: armor1.id, inventory_id: inventory.id)
        expect(inventory.armors_and_joins).to eq([[armor2, oa1], [armor1, oa2]])
      end
    end
  end
end
