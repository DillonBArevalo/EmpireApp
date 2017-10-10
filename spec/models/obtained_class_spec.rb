require 'rails_helper'

RSpec.describe ObtainedClass, type: :model do
  describe 'Associations' do
    it{should belong_to :character}
    it{should belong_to :classable}
  end
end
