class ObtainedArmorsController < ApplicationController
  def destroy
    @obtained_armor = ObtainedArmor.find(params[:id])
    @inventory = @obtained_armor.inventory
    @obtained_armor.destroy

    redirect_to @inventory
  end
end
