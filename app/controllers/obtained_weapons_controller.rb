class ObtainedWeaponsController < ApplicationController

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
