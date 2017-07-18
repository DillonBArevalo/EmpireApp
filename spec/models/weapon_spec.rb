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
end
