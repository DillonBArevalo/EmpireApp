class ObtainedWeaponsController < ApplicationController

  def destroy
    @obtained_weapon = ObtainedWeapon.find(params[:id])
    @inventory = @obtained_weapon.inventory
    auth(@inventory.character)
    @obtained_weapon.destroy
    redirect_to @inventory
  end

end
