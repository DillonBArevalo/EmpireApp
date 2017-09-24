class CharacterClassesController < ApplicationController
  def index
    @character_classes = CharacterClass.all
  end

  def show
    @character_class = CharacterClass.find(params[:id])
    @obtained_character_class = ObtainedCharacterClass.new
  end
end
