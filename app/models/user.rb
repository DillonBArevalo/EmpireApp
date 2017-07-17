class User < ApplicationRecord
  has_many :characters
  has_many :created_weapons, class_name: 'Weapon'
  has_many :created_armors, class_name: 'Armor'
end
