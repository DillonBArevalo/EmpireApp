class User < ApplicationRecord
  has_secure_password
  has_many :characters
  has_many :created_weapons, class_name: 'Weapon'
  has_many :created_armors, class_name: 'Armor'

  validates :username, presence: true, uniqueness: true
  validates :name, :email, presence: true
end
