class ObtainedWeaponsController < ApplicationController

  def create
    @character = Character.find(params[:character_id])
    @weapon = Weapon.find(params[:weapon_id])
    @character.inventory.weapons << @weapon
    respond_to do |f|
      f.html {redirect_to @character}
      f.js do
        @inventory = @character.inventory
        @equipped_weapon = EquippedWeapon.new
      end
    end
  end

  def destroy
    @obtained_weapon = ObtainedWeapon.find(params[:id])
    @inventory = @obtained_weapon.inventory
    auth(@inventory.character)
    @obtained_weapon.destroy
    respond_to do |f|
      f.html {redirect_to @inventory}
      f.js do
        @character = @inventory.character
        @weapon = @character.equipped_weapons.reject {|weapon| weapon.is_shield? }.first
        @shield = @character.equipped_weapons.select {|weapon| weapon.is_shield? }.first
        @armor = @character.equipped_armor
        @equipped_weapon = EquippedWeapon.new
      end
    end
  end

end
