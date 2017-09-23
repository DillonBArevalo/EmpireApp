class InventoriesController < ApplicationController
  def show
    @inventory = Inventory.find(params[:id])
    @character = @inventory.character
    @equipped_weapon = EquippedWeapon.new
  end

  def update
    @inventory = Inventory.find(params[:id])
    if params[:weapon_id]
      @weapon = Weapon.find(params[:weapon_id])
      @inventory.weapons << @weapon
      redirect_to @weapon
    elsif params[:armor_id]
      @armor = Armor.find(params[:armor_id])
      @inventory.armors << @armor
      redirect_to @armor
    end
  end
end
