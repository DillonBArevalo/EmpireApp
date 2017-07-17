require 'rails_helper'

RSpec.describe CharacterClass, type: :model do
  describe 'Associations' do
    let(:character_class) {CharacterClass.create(name: 'class', description: 'a class')}

    describe '#characters' do
      let(:user) {User.create({username: 'owner', name: 'tim', email: 'tim@tom.com', password: 'tomtom', password_confirmation: 'tomtom'})}
      let(:character) {user.characters.create(name: 'c', description: 'desc', strength: 11, dexterity: 11, constitution: 11, intelligence: 11, wisdom: 11, charisma: 11, energy_budget_level_bonus: 0, energy_pool_level_bonus: 0, total_skill_points: 0, available_skill_points: 0)}

      it 'returns the characters who have taken the class' do
        ObtainedCharacterClass.create(character_id: character.id, character_class_id: character_class.id, invested_points: 10)
        expect(character_class.characters).to eq([character])
      end
    end

    describe '#skills' do
      it 'returns the skills available to the class' do
        skill = character_class.skills.create(base_class_skill: true, display_description: true, tactical_maneuver_dex_bonus: false, name: 'skill', description: 'a skill')
        expect(character_class.skills).to eq([skill])
      end
    end
  end
end
