class EquippedWeaponsController < ApplicationController
  before_action do
    @character = Character.find(params[:character_id])
    auth(@character)
  end

  def create
    @weapon = Weapon.find(params[:weapon_id])
    if @weapon.weapon_classes.map {|w_class| w_class.name}.include? 'Shields'
      @character.equip_shield(@weapon)
    else
      @character.equip_weapon(@weapon)
    end
    respond_to do |f|
      f.html {redirect_to @character.inventory}
      f.js do
        @inventory = @character.inventory
        @weapon = @character.equipped_weapons.reject {|weapon| weapon.is_shield? }.first
        @shield = @character.equipped_weapons.select {|weapon| weapon.is_shield? }.first
        @armor = @character.equipped_armor
        @equipped_weapon = EquippedWeapon.new
      end
    end
  end

  def destroy
    @character.remove_weapon(params[:shield])
    respond_to do |f|
      f.html {redirect_to @character.inventory}
      f.js do
        @inventory = @character.inventory
        @weapon = @character.equipped_weapons.reject {|weapon| weapon.is_shield? }.first
        @shield = @character.equipped_weapons.select {|weapon| weapon.is_shield? }.first
        @armor = @character.equipped_armor
        @equipped_weapon = EquippedWeapon.new
      end
    end
  end

end
