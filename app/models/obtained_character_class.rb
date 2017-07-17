class ObtainedCharacterClass < ApplicationRecord
  belongs_to :character
  belongs_to :character_class
end
