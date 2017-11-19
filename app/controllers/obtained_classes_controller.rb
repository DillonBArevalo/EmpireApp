class ObtainedClassesController < ApplicationController

  def create
    @character = Character.find(params[:character_id])
    auth(@character)
    @character_class = CharacterClass.find(params[:character_class_id])
    @character.obtain_class(@character_class)
    respond_to do |f|
      f.html{redirect_to @character_class}
      f.js do
        if params[:character_show]
          @skills_ranks = @character.skills_ranks_hash
          # obtain a skill
          @unobtained_classes = CharacterClass.all - @character.character_classes
          @obtained_class = ObtainedClass.new
          render 'character_show.js.erb'
        else
          @obtained_class = ObtainedClass.new
        end
      end
    end
  end

end
