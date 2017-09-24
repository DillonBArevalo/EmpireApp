class WeaponTypesController < ApplicationController
  def index
    @weapon_types = WeaponType.all
  end

  def show
    @weapon_type = WeaponType.find(params[:id])
  end
end
