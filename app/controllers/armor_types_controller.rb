class ArmorTypesController < ApplicationController

  def index
    @armor_types = ArmorType.all
  end

  def show
    @armor_type = ArmorType.find(params[:id])
  end
end
