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
    redirect_to @character.inventory
  end

  def destroy
    @weapon = Weapon.find(params[:id])

    @character.remove_weapon(params[:shield])
    redirect_to @character.inventory
  end

end
