class CharacterClass < ApplicationRecord
  has_many :obtained_character_classes
  has_many :characters, through: :obtained_character_classes

  has_many :skills, as: :skillable
end
