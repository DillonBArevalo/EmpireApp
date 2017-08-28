class CharacterClass < ApplicationRecord
  has_many :obtained_character_classes
  has_many :characters, through: :obtained_character_classes

  has_many :skills, as: :skillable

  has_many :bcs, -> {where base_class_skill: true}, class_name: 'Skill', as: :skillable
end
