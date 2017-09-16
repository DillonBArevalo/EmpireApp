class InventoriesController < ApplicationController
  def show
    @inventory = Inventory.find(params[:id])
    @character = @inventory.character
    @equipped_weapon = EquippedWeapon.new
  end

  def update
    @weapon = Weapon.find(params[:weapon_id])
    @inventory = Inventory.find(params[:id])
    @inventory.weapons << @weapon
    redirect_to @weapon
  end
end
