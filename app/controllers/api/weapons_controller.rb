class Api::WeaponsController < ApiControllerController

  def index
    render json: {weapons: Weapon.all, weaponTypes: WeaponTypes.api_details}
  end

  def show
    @weapon = Weapon.find(params[:id])
    render json: {weapon: @weapon, weaponType: @weapon.weapon_type, damageResistances: @weapon.drs}
  end
end
