class EquippedWeaponsController < ApplicationController

  def create
    @character = Character.find(params[:character_id])
    @weapon = Weapon.find(params[:weapon_id])
    if @weapon.weapon_classes.map {|w_class| w_class.name}.include? 'Shields'
      @character.equip_shield(@weapon)
    else
      @character.equip_weapon(@weapon)
    end
    redirect_to @character.inventory
  end

  def destroy
    @character = Character.find(params[:character_id])
    @weapon = Weapon.find(params[:id])

    @character.remove_weapon(params[:shield])
    redirect_to @character.inventory
  end

end
