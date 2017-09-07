class User < ApplicationRecord
  has_secure_password
  has_many :characters
  has_many :weapons
  has_many :armors

  validates :username, presence: true, uniqueness: true
  validates :name, :email, presence: true
end
