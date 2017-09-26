class AttackOptionsController < ApplicationController
  def new
    @weapon = Weapon.find(params[:weapon_id])
    @attack_option = AttackOption.new
    @damage_types = DamageType.all
    @conditions = Condition.all
  end

  def create
    @weapon = Weapon.find(params[:weapon_id])
    if logged_in? && @weapon.user == current_user
      @user = current_user
      @attack_option = @weapon.attack_options.new(aoo_params)
      @condition1 = @attack_option.attack_options_conditions.new(condition1_params)
      @condition2 = @attack_option.attack_options_conditions.new(condition2_params)

      if @attack_option.valid? && @condition1.valid? && @condition2.valid?
        @attack_option.save
        @condition1.save
        @condition2.save
        redirect_to @weapon
      else
        @errors =  @attack_option.errors.full_messages + @condition1.errors.full_messages + @condition2.errors.full_messages
        @damage_types = DamageType.all
        @conditions = Condition.all
        render 'new'
      end
    else
      redirect_to @weapon
    end
  end

  private
  def aoo_params
    params.require(:attack_option).permit(:name, :damage_type_id, :description, :energy_modifier, :die_number, :die_size, :attack_bonus, :damage_dice, :damage_die_size, :strength_damage_bonus, :dexterity_damage_bonus, :flat_damage_bonus, :strength_dice, :dexterity_dice)
  end

  def condition1_params
    params.require(:condition1).permit(:condition_id, :threshold)
  end

  def condition2_params
    params.require(:condition2).permit(:condition_id, :threshold)
  end
end
