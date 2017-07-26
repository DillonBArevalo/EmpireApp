class Character < ApplicationRecord
  belongs_to :creator, foreign_key: :user_id, class_name: 'User'

  has_many :obtained_character_classes
  has_many :character_classes, through: :obtained_character_classes
  has_many :possible_class_skills, through: :character_classes, source: :skills
# make possible skills method that gets all weapon skills and all possible_class_skills

  has_many :obtained_skills
  has_many :improved_weapon_classes, through: :obtained_skills, source: :applicable_weapon_class
  has_many :skills, through: :obtained_skills

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


  # def equip_weapon(weapon)
  #   current_weapons = self.eqiupped_weapons.select {|weapon| weapon.weapon_class.name != 'Shields'}
  # end

  # def equip_shield(shield)

  # end

  # def obtain_skill(skill)

  # end

# Add skills!
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


private

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
