class Character < ApplicationRecord
  belongs_to :creator, foreign_key: :user_id, class_name: 'User'

  has_many :obtained_character_classes
  has_many :character_classes, through: :obtained_character_classes
  has_many :possible_class_skills, through: :character_classes, source: :skills
# make possible skills method that gets all weapon skills and all possible_class_skills

  has_many :obtained_skills
  has_many :improved_weapon_classes, through: :obtained_skills, source: :applicable_weapon_class
  has_many :skills, through: :obtained_skills
  has_many :class_bcs, through: :character_classes, source: :bcs

  has_one :inventory

  has_many :obtained_weapons, through: :inventory
  has_many :weapons, through: :obtained_weapons

  has_many :obtained_armors, through: :inventory
  has_many :armors, through: :obtained_armors

  has_one :equipped_a, class_name: 'EquippedArmor'
  has_one :equipped_armor, through: :equipped_a, source: :armor

  has_many :equipped_w, class_name: 'EquippedWeapon'
  has_many :equipped_weapons, through: :equipped_w, source: :weapon
  has_many :attack_options, through: :equipped_weapons

  # validations
  validates :strength, :dexterity, :constitution, :name, presence: true

# EXTRA STATS
  def active_defense_bonus
    ((self.constitution + self.dexterity)/2.0).ceil - 3
  end

  def active_offense_bonus
    ((self.strength + self.dexterity)/2.0).ceil
  end

  def energy_budget
    self.strength + self.dexterity - 6 + self.energy_budget_level_bonus.to_i
  end

  def energy_pool
    10 * (self.strength + self.dexterity + ((self.constitution)/2.0).ceil) + self.energy_pool_level_bonus.to_i
  end

  def hit_points
    (4 * self.constitution) + ((self.strength + self.dexterity)/2.0).ceil
  end

  def move_speed
    ((self.strength + self.dexterity)/10.0).ceil
  end



# can unequip and not reequip if fail to eqiup new weapon... fix?
  def equip_weapon(weapon)
    remove_weapon
    add_weapon(weapon)
  end

  def equip_shield(shield)
    remove_weapon(true)
    add_weapon(shield)
  end

  def equip_armor(armor)

  end

  def obtain_character_class(character_class)
    if ObtainedCharacterClass.find_by(character_class_id: character_class.id, character_id: self.id)
      {status: false, messages: ["#{self.name} already has the class #{character_class.name}"]}
    elsif self.available_skill_points < 5
      {status: false, messages: ["#{self.name} does not have enough available skill points (you have #{self.available_skill_points}) to obtain this class (requires 5)"]}
    else
      self.obtained_character_classes.create(character_class_id: character_class.id, invested_points: 5)
      self.increment!(:available_skill_points, -5)
      obtain_all_bcs(character_class)
      {status: true, messages: ["#{self.name} has obtained the class #{character_class.name} and the associated base class skills!"]}
    end
  end

# Add skills!
  def obtain_skill(skill, weapon_class=nil)
    join = ObtainedSkill.find_by(character_id: self.id, skill_id: skill.id)
    response = {status: true, messages: []}

    # check permissions
    check_class(response, skill)
    if check_rank_available(response, skill, join)
      check_enough_points(response, skill, join)
    end
    return response unless response[:status]

    #add to ranks
    if join
      join.increment!(:ranks)
    else
      join = self.obtained_skills.create(skill_id: skill.id, applicable_weapon_class_id: skill.weapon_class, ranks: 1)
    end

    # remove used sp from available_skill_points
    cost = skill.cost_at_rank(join.ranks)
    self.increment!(:available_skill_points, -cost)
    increase_class_stat_points(skill, cost)
    response[:messages] << "#{self.name} successfully obtained #{skill.name} at rank #{join.ranks} for #{cost} skill points."
    response
  end

  # def generate_attack_string(attack_option)
  #   base = self.active_offense_bonus
  #   base += attack_option.attack_bonus
  #   e_mod = attack_option.energy_modifier
  #   # if attack_option.weapon.weapon_types.any? {|type| type.name = "Shield" }
  #     # if self.skills

  #   # end
  #   dice = attack_dice(attack_option)
  #   "#{e_mod} x Energy Input + #{base} + #{dice}"
  # end

  # def generate_damage_string(attack_option)

  # end

  # def generate_defense_string(weapon)

  # end

  # def class_skills_bonus

  # end

  def tactical_maneuver
    "#{self.dexterity} + 1d20"
  end

  def jump
    if self.skills.any? {|skill| skill.tactical_maneuver_dex_bonus }
      tactical_maneuver + " + 1d#{stat_die(self.dexterity)}"
    else
      tactical_maneuver
    end
  end

  def free_hands
    2 - self.equipped_weapons.reduce(0) {|hands,w| hands + w.hands_used}
  end

  def add_skill_points(new_points)
    add_to_energy_upgrade_points(new_points)
    self.increment!(:total_skill_points, new_points)
    self.increment!(:available_skill_points, new_points)
  end

private

  def obtain_all_bcs(character_class)
    character_class.bcs.each do |skill|
      self.obtained_skills.create(skill_id: skill.id, ranks: 1)
    end
  end

  def increase_class_stat_points(skill, cost)
    if skill.skillable_type = "CharacterClass"
      class_id = skill.skillable_id
      obtained_class = ObtainedCharacterClass.find_by(character_id: self.id, character_class_id: class_id)
      add_points_to_class(obtained_class, cost)
    end
  end

  # Add to bcs then add to invested points
  def add_points_to_class(obtained_character_class, cost)
    # grab ranks
    current_sp_mod_5 = obtained_character_class.invested_points % 5
    additional_ranks = (current_sp_mod_5 + cost)/5

    # level up bcs
    bcs = self.class_bcs.select {|skill| skill.skillable_id == obtained_character_class.character_class_id}
    obtained_bcs = bcs.map {|skill| ObtainedSkill.find_by(skill_id: skill.id, character_id: self.id)}
    obtained_bcs.each {|obtained_skill| obtained_skill.increment!(:ranks, additional_ranks)}

    # add to invested points
    obtained_character_class.increment!(:invested_points, cost)
  end

  def check_class(response, skill)
    if skill.skillable_type = "CharacterClass"
      unless self.possible_class_skills.exists?(skill.id)
        response[:status] = false
        response[:messages] << 'You do not have the class required to obtain this skill'
      end
    end
  end

# return false if fails
  def check_rank_available(response, skill, join)
    if join && (join.ranks == skill.ranks_available)
      response[:status] = false
      response[:messages] << 'You have already achieved the maximum rank for this skill'
      false
    else
      true
    end
  end

  def check_enough_points(response, skill, join)
    rank = (join ? join.ranks : 0)
    if skill.cost_at_rank(rank + 1) > self.available_skill_points
      response[:status] = false
      response[:messages] << "You don't have enough skill points to obtain the next rank of this skill"
    end
  end

  def add_weapon(weapon)
    if free_hands >= weapon.hands_used
      self.equipped_weapons << weapon
      true
    else
      false
    end
  end

  def remove_weapon(shield=false)
    if shield
      equipped_shield = self.equipped_weapons.select {|weapon| weapon.is_shield?}[0]
      self.equipped_weapons.delete(equipped_shield) if equipped_shield
    else
      other = self.equipped_weapons.select {|weapon| !weapon.is_shield?}[0]
      self.equipped_weapons.delete(other) if other
    end
  end


# Add skills!
  # def attack_dice(attack_option)
  #   die_size = attack_option.die_size
  #   die_number = attack_option.die_number
  #   second_die_number = 0
  #   third_die_number = 0
  #   str_die_size = stat_die(self.strength)
  #   dex_die_size = stat_die(self.dexterity)
  #   if die_size == str_die_size
  #     die_number += attack_option.strength_dice
  #   else
  #     second_die_number = attack_option.strength_dice
  #   end
  #   if die_size == dex_die_size
  #     die_number += attack_option.dexterity_dice
  #   elsif dex_die_size == str_die_size
  #     second_die_number += attack_option.dexterity_dice
  #   else
  #     third_die_number +=attack_option.dexterity_dice
  #   end
  #   "#{die_string(die_number, die_size, true)}#{die_string(second_die_number, str_die_size, true)}#{die_string(third_die_number, dex_die_size, true)}"
  # end

  def add_to_energy_upgrade_points(new_points)
    current_sp_mod_5 = self.total_skill_points  % 5
    additional_points = (current_sp_mod_5 + new_points)/5
    self.increment!(:unspent_energy_upgrade_points, additional_points)
  end

  def die_string(number, size, plus=false)
    if number > 0
      if plus
        " + #{number}d#{size}"
      else
        "#{number}d#{size}"
      end
    else
      ''
    end
  end

  def stat_die(stat)
    if stat <= 10
      4
    elsif stat <= 13
      6
    elsif stat <=16
      8
    else
      10
    end
  end

end
