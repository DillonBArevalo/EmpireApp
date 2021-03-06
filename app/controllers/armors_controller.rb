class ArmorsController < ApplicationController

  def index
    @armor_types = ArmorType.all.map {|armor_type| [armor_type, Armor.where(user_id: 1, armor_type_id: armor_type.id), Armor.where('user_id != 1 AND armor_type_id = ' + armor_type.id.to_s)]}
  end

  def new
    auth
    @armor_types = ArmorType.all
    @armor = Armor.new
    @drs = []
    respond_to do |f|
      f.html {}
      f.js {}
    end
  end

  def create
    if logged_in?
      @user = current_user
    else
      redirect_to '/login'
    end

    @armor = @user.armors.new(new_armor_params)
    @drs = drs_from_params
    if @armor.save
      @armor.generate_drs(@drs)
      respond_to do |f|
        f.html {redirect_to @armor}
        f.js {@success = 'true'}
      end
    else
      @armor_types = ArmorType.all
      @errors = @armor.errors.full_messages
      respond_to do |f|
        f.html {render 'new'}
        f.js {@success = 'false'}
      end
    end
  end

  def show
    @armor = Armor.find(params[:id])
    respond_to do |f|
      f.html {}
      f.js {@header = @armor.name}
    end
  end

  def edit
    @armor = Armor.find(params[:id])
    auth(@armor)
    @armor_types = ArmorType.all # not going to default correctly
    @drs = @armor.drs.split('/')
    render 'new' # should be form partial and render edit here
  end

  def update
    @armor = Armor.find(params[:id])
    auth(@armor)
    updates = []
    updates << @armor.update(new_armor_params)
    @drs = drs_from_params
    old_drs = @armor.damage_resistances
    old_drs.each_with_index do |dr, idx|
      updates << dr.update(amount: @drs[idx])
    end
    if updates.any? {|update| !update}
      @errors = ([@armor] + old_drs).reduce([]) {|errors, model| errors + model.errors.full_messages}
      @armor_types = ArmorType.all
      render 'edit'
    else
      redirect_to @armor
    end
  end

  def destroy
    @armor = Armor.find(params[:id])
    auth(@armor)
    if @armor.inventories.empty?
      @armor.destroy
      redirect_to '/armors'
    else
      redirect_to @armor
    end
  end

  private

  def new_armor_params
    params.require(:armor).permit(:name, :description, :armor_type_id, :passive_defense_bonus, :active_action_reduction, :budget_reduction, :energy_pool_reduction, :dodge_energy_mod_penalty, :dodge_die_size_reduction)
  end

  def drs_from_params
    stats = []
    params.require(:dr).permit(:slashing, :piercing, :bludgeoning, :bludgeoning_slashing, :bludgeoning_piercing).each {|type, stat| stats << stat}
    stats
  end

end
