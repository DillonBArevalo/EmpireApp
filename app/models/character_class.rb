class CharacterClass < ApplicationRecord
  has_many :obtained_character_classes
  has_many :characters, through: :obtained_character_classes

  has_many :skills, as: :skillable
  has_many :passive_skills, -> {where passive: true}, class_name: 'Skill', as: :skillable
  has_many :active_skills, -> {where passive: false}, class_name: 'Skill', as: :skillable

  has_many :bcs, -> {where base_class_skill: true}, class_name: 'Skill', as: :skillable
end
