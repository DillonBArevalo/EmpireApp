class User < ApplicationRecord
  has_secure_password
  has_many :characters
  has_many :weapons
  has_many :armors

  validates :username, :email, presence: true, uniqueness: true
  validates :name, presence: true
end
