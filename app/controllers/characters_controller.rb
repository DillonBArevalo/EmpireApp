class CharactersController < ApplicationController

  def index
    @characters = Character.all.order('name ASC')
  end

  def new
    auth
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
    @skills_ranks = @character.skills_ranks_hash
    @inventory = @character.inventory
    @weapon = @character.equipped_weapons.reject {|weapon| weapon.is_shield? }.first
    @shield = @character.equipped_weapons.select {|weapon| weapon.is_shield? }.first
    @armor = @character.equipped_armor
    if @character.creator == current_user
      @equipped_weapon = EquippedWeapon.new
      @obtained_classes = @character.character_classes
      @unobtained_classes = CharacterClass.all - @obtained_classes
      @weapon_classes = WeaponClass.all
      @obtained_class = ObtainedClass.new
    end
  end

  def edit
    @character = Character.find(params[:id])
    auth(@character)
  end

  def update
    @character = Character.find(params[:id])
    if @character.creator != current_user
      redirect_to @character
    elsif params[:armor_id]
      if params[:unequip]
        @character.remove_armor
      else
        @character.equip_armor(Armor.find(params[:armor_id]))
      end
      respond_to do |f|
        f.html {redirect_to @character.inventory}
        f.js do
          @inventory = @character.inventory
          @weapon = @character.equipped_weapons.reject {|weapon| weapon.is_shield? }.first
          @shield = @character.equipped_weapons.select {|weapon| weapon.is_shield? }.first
          @armor = @character.equipped_armor
          @equipped_weapon = EquippedWeapon.new
        end
      end
    elsif params[:add_skill_points]
      @character.add_skill_points(params[:skill_points].to_i)
      redirect_to @character
    elsif params[:upgrade]
      @character.spend_upgrade_points(upgrade_params)
      redirect_to @character
    else
      if @character.update(new_character_params)
        redirect_to @character
      else
        @errors = @character.errors.full_messages
        render 'edit'
      end
    end
  end

  def destroy
    @character = Character.find(params[:id])
    auth(@character)
    @character.destroy
    redirect_to current_user
  end

  private

  def upgrade_params
    params.require(:character).permit(:budget_amount, :pool_amount)
  end

  def new_character_params
    params.require(:character).permit(:name, :description, :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma)
  end
end
