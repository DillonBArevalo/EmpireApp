class CharactersController < ApplicationController

  def index
    @characters = Character.all.order('name ASC')
  end

  def new
    @character = Character.new
  end

  def create
    if logged_in?
      @user = current_user
    else
      redirect_to '/login'
    end
    @character = @user.characters.new(new_character_params)

    if @character.save
      Inventory.create(character_id: @character.id)
      redirect_to @character
    else
      @errors = @character.errors.full_messages
      render 'new'
    end
  end

  def show
    @character = Character.find(params[:id])
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def new_character_params
    params.require(:character).permit(:name, :description, :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma)
  end
end
