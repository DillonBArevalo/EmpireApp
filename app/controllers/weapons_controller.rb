class WeaponsController < ApplicationController

  def index
    @weapon_classes = WeaponClass.all.map {|w_class| [w_class, w_class.weapons.where(user_id: 1), w_class.weapons.where.not(user_id: 1)]}
  end

  def new
    @weapon = Weapon.new
    @damage_types = DamageType.all
    @attack_option = AttackOption.new
    @weapon_types = WeaponType.all
    @weapon_classes = WeaponClass.all
    @conditions = Condition.all
  end

  def create
    if logged_in?
      @user = current_user
    else
      redirect_to '/login'
    end

  # refactor to use a weapon method to create everything else in one line?
  # also maybe add validations to AttackOptionsCondition
    @weapon = @user.weapons.new(new_weapon_params)
    @attack_option = @weapon.attack_options.new(aoo_params)
    @condition1 = @attack_option.attack_options_conditions.new(condition1_params)
    @condition2 = @attack_option.attack_options_conditions.new(condition2_params)
    @weapon.weapon_classes << WeaponClass.find(params[:weapon_class_id])
    if @weapon.valid? && @attack_option.valid? && @condition1.valid? && @condition2.valid?
      @weapon.save
      @attack_option.save
      @condition1.save
      @condition2.save
      redirect_to @weapon
    else
      @errors = @weapon.errors.full_messages
      @errors2 =  @attack_option.errors.full_messages + @condition1.errors.full_messages + @condition2.errors.full_messages
      @damage_types = DamageType.all
      @weapon_types = WeaponType.all
      @conditions = Condition.all
      @weapon_classes = WeaponClass.all
      render 'new'
    end
  end

  def show
    @weapon = Weapon.find(params[:id])
    @attack_options = @weapon.attack_options
    @character = Character.first
  end

  def edit
    @weapon = Weapon.find(params[:id])
    @damage_types = DamageType.all
    @attack_option = @weapon.attack_options.first
    @weapon_types = WeaponType.all
    @weapon_classes = @character.weapon_classes
    @conditions = Condition.all
    render 'new'
  end

  def update

  end

  def destroy
    @weapon = Weapon.find(params[:id])
    if @weapon.inventories.empty?
      @weapon.destroy
      redirect_to '/weapons'
    else
      redirect_to @weapon
    end
  end

  private

  def condition1_params
    params.require(:condition1).permit(:condition_id, :threshold)
  end

  def condition2_params
    params.require(:condition2).permit(:condition_id, :threshold)
  end

  def new_weapon_params
    params.require(:weapon).permit(:weapon_type_id, :name, :description, :defense_die_number, :defense_die_size, :flat_defense_bonus, :defense_energy_modifier, :extra_attack_cost, :extra_block_cost, :hands_used, :dodge_energy_mod_penalty)
  end

  def aoo_params
    params.require(:attack_option).permit(:name, :damage_type_id, :description, :energy_modifier, :die_number, :die_size, :attack_bonus, :damage_dice, :damage_die_size, :strength_damage_bonus, :dexterity_damage_bonus, :flat_damage_bonus, :strength_dice, :dexterity_dice)
  end
end
