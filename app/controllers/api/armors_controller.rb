class Api::ArmorsController < ApiControllerController

  def index
    render json: {armors: Armor.all, armorTypes: ArmorType.api_details}
  end

  def show
    @armor = Armor.find(params[:id])
    render json: {armor: @armor, armorType: @armor.armor_type, damageResistances: @armor.drs}
  end
end
