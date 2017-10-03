class ObtainedClass < ApplicationRecord
  belongs_to :character
  belongs_to :classable, polymorphic: true
end
