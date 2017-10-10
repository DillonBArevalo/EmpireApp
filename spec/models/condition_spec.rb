require 'rails_helper'

#This one got all screwed up. When I used let for all variables it all blew up

RSpec.describe Condition, type: :model do
  describe 'Associations' do
    describe '#attack_options_conditions' do
      it{should have_many :attack_options_conditions}
    end

    describe '#damage_types' do
      it{should have_many :damage_types}
    end

    describe '#weapons' do
      # p 'THIS SEEMS TO FAIL IN IRB! FAILED TEST BEFORE SHOULDA MATCHERS TOO. MAYBE A REAL ISSUE HERE?'
      it{should have_many :weapons}
    end

    describe '#weapon_classes' do
      it{should have_many :weapon_classes}
    end
  end
end
