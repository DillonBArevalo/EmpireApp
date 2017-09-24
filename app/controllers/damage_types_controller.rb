class DamageTypesController < ApplicationController
  def index
    @damage_types = DamageType.all
  end
end
