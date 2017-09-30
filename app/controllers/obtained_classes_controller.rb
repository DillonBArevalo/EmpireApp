class ObtainedClassesController < ApplicationController

  def create
    @character = Character.find(params[:character_id])
    @character_class = CharacterClass.find(params[:character_class_id])
    @character.obtain_class(@character_class)

    redirect_to @character_class
  end

end
