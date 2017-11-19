class WeaponsController < ApplicationController

  def index
    @weapon_classes = WeaponClass.all.map {|w_class| [w_class, w_class.weapons.where(user_id: 1), w_class.weapons.where.not(user_id: 1)]}
  end

  def new
    auth
    @weapon = Weapon.new
    @weapon_types = WeaponType.all.reject {|weapon_type| weapon_type.name.downcase.include?('shield')}
    @weapon_classes = WeaponClass.all.reject {|weapon_class| weapon_class.name.downcase.include?('shield')}
  end

  def new_shield
    auth
    @weapon = Weapon.new
    @weapon_types = WeaponType.all.select {|weapon_type| weapon_type.name.downcase.include?('shield')}
    @weapon_classes = WeaponClass.all.select {|weapon_class| weapon_class.name.downcase.include?('shield')}
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
    @weapon.weapon_classes << WeaponClass.find(params[:weapon_class_id])
    if @weapon.save
      if params[:attack_option]
        redirect_to new_weapon_attack_option_url(@weapon)
      else
        redirect_to @weapon
      end
    else
      @errors = @weapon.errors.full_messages
      if params[:shield]
        @weapon_types = WeaponType.all.select {|weapon_type| weapon_type.name.downcase.include?('shield')}
        @weapon_classes = WeaponClass.all.select {|weapon_class| weapon_class.name.downcase.include?('shield')}
        render 'new_shield'
      else
        @weapon_types = WeaponType.all.reject {|weapon_type| weapon_type.name.downcase.include?('shield')}
        @weapon_classes = WeaponClass.all.reject {|weapon_class| weapon_class.name.downcase.include?('shield')}
        render 'new'
      end
    end
  end

  def show
    @weapon = Weapon.find(params[:id])
    @empty = @weapon.inventories.empty?
    @attack_options = @weapon.attack_options
    @character = Character.first
    respond_to do |f|
      f.html {}
      f.js {@header = @weapon.name}
    end
  end

  def edit
    @weapon = Weapon.find(params[:id])
    auth(@weapon)
    @damage_types = DamageType.all
    @attack_option = @weapon.attack_options.first
    @weapon_types = WeaponType.all.reject {|weapon_type| weapon_type.name.downcase.include?('shield')}
    @weapon_classes = WeaponClass.all.reject {|weapon_class| weapon_class.name.downcase.include?('shield')}
    @conditions = Condition.all
  end

  def edit_shield
    @weapon = Weapon.find(params[:id])
    auth(@weapon)
    @damage_types = DamageType.all
    @attack_option = @weapon.attack_options.first
    @weapon_types = WeaponType.all.select {|weapon_type| weapon_type.name.downcase.include?('shield')}
    @weapon_classes = WeaponClass.all.select {|weapon_class| weapon_class.name.downcase.include?('shield')}
    @conditions = Condition.all
  end

  def update
    @weapon = Weapon.find(params[:id])
    auth(@weapon)
    @user = current_user

  # refactor to use a weapon method to create everything else in one line?
  # also maybe add validations to AttackOptionsCondition
    @attack_option = @weapon.attack_options.first
    @condition1 = @attack_option.attack_options_conditions.first
    @condition2 = @attack_option.attack_options_conditions.second
    @weapon.weapon_classes = [WeaponClass.find(params[:weapon_class_id])]
    if @weapon.update(new_weapon_params) && @attack_option.update(aoo_params) && @condition1.update(condition1_params) && @condition2.update(condition2_params)
      redirect_to @weapon
    else
      @errors = @weapon.errors.full_messages
      @errors2 =  @attack_option.errors.full_messages + @condition1.errors.full_messages + @condition2.errors.full_messages
      @damage_types = DamageType.all
      if @weapon.weapon_classes.any? {|weapon_class| weapon_class.name.downcase.include?('shield')}
        @weapon_types = WeaponType.all.select {|weapon_type| weapon_type.name.downcase.include?('shield')}
        @weapon_classes = WeaponClass.all.select {|weapon_class| weapon_class.name.downcase.include?('shield')}
      else
        @weapon_types = WeaponType.all.reject {|weapon_type| weapon_type.name.downcase.include?('shield')}
        @weapon_classes = WeaponClass.all.reject {|weapon_class| weapon_class.name.downcase.include?('shield')}
      end
      @conditions = Condition.all
      params[:shield] ? (render 'edit_shield') : (render 'edit')
    end
  end

  def destroy
    @weapon = Weapon.find(params[:id])
    auth(@weapon)
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
