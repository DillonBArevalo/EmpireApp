class InventoriesController < ApplicationController
  def show
    @inventory = Inventory.find(params[:id])
    @character = @inventory.character
    @weapon = @character.equipped_weapons.reject {|weapon| weapon.is_shield? }.first
    @shield = @character.equipped_weapons.select {|weapon| weapon.is_shield? }.first
    @armor = @character.equipped_armor
    @equipped_weapon = EquippedWeapon.new
  end

  def update
    @inventory = Inventory.find(params[:id])
    auth(@inventory.character)
    if params[:weapon_id]
      @weapon = Weapon.find(params[:weapon_id])
      @inventory.weapons << @weapon
      respond_to do |f|
        f.html{redirect_to @weapon}
        f.js{@type = 'weapons'}
      end
    elsif params[:armor_id]
      @armor = Armor.find(params[:armor_id])
      @inventory.armors << @armor
      respond_to do |f|
        f.html{redirect_to @armor}
        f.js{@type = 'armors'}
      end
    end
  end
end
