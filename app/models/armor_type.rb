class ArmorType < ApplicationRecord
  has_many :armors

  def self.api_details
    self.ids.zip(self.order(:id)).to_h
  end
end
