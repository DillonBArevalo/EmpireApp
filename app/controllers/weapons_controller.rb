class WeaponsController < ApplicationController

  def index
    @weapon_classes = WeaponClass.all
  end

  def new
    @weapon = Weapon.new
    @damage_types = DamageType.all
    @attack_option = AttackOption.new
    @weapon_types = WeaponType.all
    @weapon_classes = WeaponClass.all
  end

  def create
    if logged_in?
      @user = current_user
    else
      redirect_to '/login'
    end

    @weapon = @user.weapons.new(new_weapon_params)
    @attack_option = @weapon.attack_options.new(aoo_params)
    if @weapon.valid? && @attack_option.valid?
      @weapon.save
      @attack_option.save
      @weapon.weapon_classes << WeaponClass.find(params[:weapon_class_id])
      redirect_to @weapon
    else
      @errors = @weapon.errors.full_messages + @attack_option.errors.full_messages
      @damage_types = DamageType.all
      @weapon_types = WeaponType.all
      p @attack_option.description
      @weapon_classes = WeaponClass.all
      render 'new'
    end
  end

  def show
    @weapon = Weapon.find(params[:id])
    @attack_options = @weapon.attack_options
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def new_weapon_params
    params.require(:weapon).permit(:weapon_type_id, :name, :description, :defense_die_number, :defense_die_size, :flat_defense_bonus, :defense_energy_modifier, :extra_attack_cost, :extra_block_cost, :hands_used, :dodge_energy_mod_penalty)
  end

  def aoo_params
    params.require(:attack_option).permit(:name, :damage_type_id, :description, :energy_modifier, :die_number, :die_size, :attack_bonus, :damage_dice, :damage_die_size, :strength_damage_bonus, :dexterity_damage_bonus, :flat_damage_bonus)
  end
end
