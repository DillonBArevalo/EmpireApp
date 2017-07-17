require 'rails_helper'

RSpec.describe AttackOption, type: :model do
  describe 'Associations' do
    let(:user) {User.create({username: 'creator', name: 'tom', email: 'tom@tom.com', password: 'tomtom', password_confirmation: 'tomtom'})}
    let(:weapon_type) {WeaponType.create(name: 'name')}
    let(:weapon) {Weapon.create(user_id: user.id, weapon_type_id: weapon_type.id, name: 'weapon', description: 'a weapon', defense_die_number: 1, defense_die_size: 4, flat_defense_bonus: 1, defense_energy_modifier: 1, extra_attack_cost: 25, extra_block_cost: 25, hands_used: 1)}
    let(:type) {DamageType.create(name: 'type1', description: 'a test type')}
    let(:attack_option) {AttackOption.create(name: 'attack_option', description: 'an attack option', weapon_id: weapon.id, strength_dice: 1, dexterity_dice: 1, energy_modifier: 1, die_number: 1, die_size: 4, damage_dice: 1, damage_die_size: 4, strength_damage_bonus: 2, dexterity_damage_bonus: 2, flat_damage_bonus: 1, damage_type_id: type.id)}

    describe '#weapon' do
      it 'returns the weapon that has that attack option' do
        expect(attack_option.weapon).to eq(weapon)
      end
    end

    describe '#damage_type' do
      it 'returns the damage type of the attack' do
        expect(attack_option.damage_type).to eq(type)
      end
    end

    describe '#conditions' do
      it 'returns the conditions for the attack options' do
        condition1 = Condition.create(name: 'condition', description: 'a condition', effect_description: 'it messes you up. like... real bad.')
        condition2 = Condition.create(name: 'second condition', description: 'another condition', effect_description: 'it also messes you up. but, like... way worse.')
        AttackOptionsCondition.create(attack_option_id: attack_option.id, condition_id: condition1.id, threshold: 12)
        AttackOptionsCondition.create(attack_option_id: attack_option.id, condition_id: condition2.id, threshold: 22)
        expect(attack_option.conditions).to eq([condition1, condition2])
      end
    end
  end
end
