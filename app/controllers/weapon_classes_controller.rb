class WeaponClassesController < ApplicationController
  def index
    @weapon_classes = WeaponClass.all
  end

  def show
    @weapon_class = WeaponClass.find(params[:id])
  end
end
