class ObtainedArmorsController < ApplicationController

  def create
    @character = Character.find(params[:character_id])
    @armor = Armor.find(params[:armor_id])
    @character.inventory.armors << @armor
    respond_to do |f|
      f.html {redirect_to @character}
      f.js do
        @inventory = @character.inventory
        @equipped_armor = EquippedWeapon.new
      end
    end
  end

  def destroy
    @obtained_armor = ObtainedArmor.find(params[:id])
    @inventory = @obtained_armor.inventory
    auth(@inventory.character)
    @obtained_armor.destroy

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
