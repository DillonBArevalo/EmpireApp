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
    @character = Character.find(params[:id])
    if params[:armor_id]
      if params[:unequip]
        @character.remove_armor
      else
        @character.equip_armor(Armor.find(params[:armor_id]))
      end
      redirect_to @character.inventory
    elsif params[:add_skill_points]
      @character.add_skill_points(params[:skill_points].to_i)
      redirect_to @character
    elsif params[:upgrade]
      @character.spend_upgrade_points(upgrade_params)
      redirect_to @character
    end
  end

  def destroy

  end

  private

  def upgrade_params
    params.require(:character).permit(:budget_amount, :pool_amount)
  end

  def new_character_params
    params.require(:character).permit(:name, :description, :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma)
  end
end
