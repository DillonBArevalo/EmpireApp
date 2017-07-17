require 'rails_helper'

RSpec.describe ArmorType, type: :model do
  describe 'Associations' do
    describe '#armors' do
      it 'returns the armors of the given type' do
        type = ArmorType.create({name: 'armor'})
        user = User.create({username: 'creator', name: 'tom', email: 'tom@tom.com', password: 'tomtom', password_confirmation: 'tomtom'})
        armor1 = Armor.create({user_id: user.id, name: 'armor', armor_type_id: type.id, passive_defense_bonus: 1, active_action_reduction: 1, budget_reduction: 1, dodge_energy_mod_penalty: 0, dodge_die_size_reduction: 0})
        armor2 = Armor.create({user_id: user.id, name: 'armor2', armor_type_id: type.id, passive_defense_bonus: 11, active_action_reduction: 11, budget_reduction: 11, dodge_energy_mod_penalty: 10, dodge_die_size_reduction: 10})
        expect(type.armors).to eq([armor1, armor2])
      end
    end
  end
end
