require 'rails_helper'

RSpec.describe Weapon, type: :model do
  describe 'Associations' do
    it { should belong_to :user }
    it { should belong_to :weapon_type }

    it { should have_many :weapon_classes_weapons }
    it { should have_many :weapon_classes}
    it { should have_many :skills}
    it { should have_many :skill_costs}

    it { should have_many :attack_options }
    it { should have_many :damage_types}
    it { should have_many :attack_options_conditions}
    it { should have_many :conditions}

    it { should have_many :equipped_weapons }
    it { should have_many :characters}

    it { should have_many :obtained_weapons }
    it { should have_many :inventories}
  end

  describe '#is_shield?' do
    it 'returns true when the weapon is a shield' do
      core_user = User.create(username: 'Empire: core', email: 'dillonbarevalo@gmail.com', name: 'Dillon and Jack', password: 'donothackme', password_confirmation: 'donothackme')
      light_shield = WeaponType.create!(name: 'Light shield')
      shield = Weapon.new(user_id: core_user.id, weapon_type_id: light_shield.id, name: 'Light Shield', description: '', defense_die_number: 1, defense_die_size: 10, flat_defense_bonus: 4, defense_energy_modifier: 2, extra_block_cost: 30, hands_used: 1)
      shields = WeaponClass.create!(name: 'Shields', description: "U")
      shield.weapon_classes << shields
      expect(shield.is_shield?).to be true
    end

    it 'returns false otherwise' do
      core_user = User.create(username: 'Empire: core', email: 'dillonbarevalo@gmail.com', name: 'Dillon and Jack', password: 'donothackme', password_confirmation: 'donothackme')
      axe = WeaponType.create!(name: 'Axe')
      b_axe = Weapon.new(user_id: core_user.id, weapon_type_id: axe.id, name: 'Battle Axe', description: '', defense_die_number: 1, defense_die_size: 10, flat_defense_bonus: 5, defense_energy_modifier: 1, extra_block_cost: 30, extra_attack_cost: 30, hands_used: 2, dodge_energy_mod_penalty: 0.5)
      class1 = WeaponClass.create!(name: 'Power Weapons', description: "Th")
      b_axe.weapon_classes << class1
      expect(b_axe.is_shield?).to be false
    end
  end
end
