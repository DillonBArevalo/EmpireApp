class ObtainedClassesController < ApplicationController

  def create
    @character = Character.find(params[:character_id])
    auth(@character)
    @character_class = CharacterClass.find(params[:character_class_id])
    @character.obtain_class(@character_class)
    respond_to do |f|
      f.html{redirect_to @character_class}
      f.js { @obtained_class = ObtainedClass.new }
    end
  end

end
