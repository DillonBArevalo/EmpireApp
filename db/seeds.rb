# Users
core_user = User.create!(username: 'Empire: core', email: 'dillonbarevalo@gmail.com', name: 'Dillon and Jack', password: 'donothackme', password_confirmation: 'donothackme')

# Characters
character = Character.create!(user_id: core_user.id, name: 'Display Character', description: 'A character with a generic stat line to show off equipment', strength: 12, dexterity: 12, constitution: 12, intelligence: 12, wisdom: 12, charisma: 12)
Inventory.create!(character_id: character.id)

# Weapon Classes
class1 = WeaponClass.create!(name: 'Power Weapons', description: "These weapons include such things as axes, clubs, and heavy swords. The trees for power weapons are fairly minimal and scale off of strength. These weapons are strong without any skills spent in them with average to high attack and high damage. Type 1 Weapons are wielded with either 1 or 2 hands, depending on the weapon. These weapons are somewhat lacking in defense, but to a low level character, the offensive capabilities they have are simply devastating. The problem with Class 1 weapons is they have few skills to boost their attack and few skills which add meaningful tactical choices, making them scale very poorly into the late game. No matter how high their damage gets, if you can’t hit someone, you can’t hurt them.")
class2 = WeaponClass.create!(name: "Finesse Weapons", description: "Type 2 weapons are one handed weapons that can be wielded by themselves, with another weapon (not yet), or with a shield. These weapons are often difficult to use initially but scale very well when skill points are sunk into them. They scale off of either dexterity and strength, or one of the two. Class 2 weapons have low damage and low attack numbers initially (though they usually have fairly high defensive numbers) but can scale the attack extremely well and damage numbers fairly well. What they lack in early game strength they make up for in both late game strength and the defensive capabilities (especially when coupled with a shield) to get you there.")
shields = WeaponClass.create!(name: 'Shields', description: "Ultimately probably won't be a weapon class, but at the moment the website is young enough that I haven't separated them yet. It's a shield, silly.")

# Damage Types
slashing = DamageType.create!(name: 'Slashing', description: 'A cut without much impact behind it. Think the cut of a light sword.')
piercing = DamageType.create!(name: 'Piercing', description: 'An impact with a sharp weapon, but not one with incredible mass behind it. Think arrow or rapier thrust.')
bludgeoning = DamageType.create!(name: 'Bludgeoning', description: 'A heavy impact where no sharp edge is present. Think clubs and hammers.')
bludgeoning_slashing = DamageType.create!(name: 'Bludgeoning/Slashing', description: 'A heavy impact with an edged weapon. Think large axes or heavy swords. Less of a slice and more of a cleave.')
bludgeoning_piercing = DamageType.create!(name: 'Bludgeoning/Piercing', description: 'An impact with a sharp point meant to penetrate. Think war picks and half swording.')

# Armor Types
light_armor = ArmorType.create!(name: 'Light', description: 'Light armor usually contains little to no metal. It is maneuverable and doesn\'t weigh you down very much but will offer relatively little protection. ')
medium_armor = ArmorType.create!(name: 'Medium', description: 'Medium armor offers a good balance between protection and speed. It won\'t help very much against the heaviest of attacks, but will significantly reduce damage from lighter attacks and give you some defense against strikes you aren\'t able to block.')
heavy_armor = ArmorType.create!(name: 'Heavy', description: 'Unless excellently made heavy armor will be heavy and stifling. It may be ill fitted or poorly crafted but it will likely significantly impede your motion and tire you out much more quickly. It will, however, offer significant defense against attacks, and even when attacks do land there isn\'t a bad chance that they will be rendered utterly ineffective.')

# Conditions
bleeding = Condition.create!(name: "Bleeding", description: "A character has begun bleeding to a significant enough extent that they must pay attention to it.", effect_description: "A bleeding character must spend 10 percent of their energy budget per round on ignoring the wound and staying in combat. Bleeding can stack exactly twice. SAVE: roll under CON by 3 (three times your CON stat) to negate.")
wounded = Condition.create!(name: "Wounded", description: 'A character has an open wound. Movement may tear it and/or cause significant pain. Bleeding is likely to follow.', effect_description: "Using more than 3/4 of round budget used inflicts 1d4 damage per excess point of energy. Heal or significant rest ends. Triggers Bleeding after one cycle. Stacking wounds increases the damage dealt (by 1d4 per energy point) but not the threshold for it. SAVE: roll under CON by 2 (two times your CON stat) to negate.")
severed_tendon = Condition.create!(name: "Severed Tendon", description: "A character has had one of their tendons cut and can no longer control the associated limb at all as they cannot engage their muscles", effect_description: "Triggered during a failed block or dodge (if triggered from Sweep count it as a leg regardless of type of defensive maneuver), where the effect is triggered for the arm that was used to block, or a leg if used for the dodge, and thus can no longer be used. If a leg has a tendon severed movement is halved and sprinting becomes impossible. Also triggers Wounded without Bleeding. If the attack that triggered severed tendon was not blocked or dodged the attacker may choose the limb to damage")
off_balance = Condition.create!(name: "Off Balance", description: "A character has lost their balance and is in danger of falling over.", effect_description: "While off balance, every action that creates a MoV has a shift of -1 to the off balance character applied on it. If an character under the Off Balance condition is knocked off balance a second time that character is knocked prone. Some skills (eventually) will allow execution of maneuvers in off balance positions. Recovery may be made at the beginning of a cycle by sacrificing one’s offensive round, and movement speed is halved.")
Condition.create!(name: "Prone", description: "A character has fallen over! There is not currently (and may never be) a difference between prone (on belly) and supine (on back).", effect_description: "While Prone apply a -2 shift in MoV. Recovery may be attempted at the beginning of a cycle by sacrificing half of one’s energy budget and sacrificing one’s offensive round; no movement be taken save a required Repositioning Check to stand back up (which can incur more MoV shifts upon failure).")
broken_bone = Condition.create!(name: "Broken Bone", description: "A character has broken a bone and cannot use the limb effectively anymore.", effect_description: "Cannot use limbs associated with broken bones without a massive energy drain. If limbs associated with the injury are used anyway, they incur a -1 MoV shift. SAVE: roll under CON by 1 (your CON stat) to negate.")
Condition.create!(name: "Shock", description: "Shock is triggered by any specific weapon but instead by any weapon upon dealing massive damage in a single strike. A character in shock must save or go unconscious, becoming completely drained of energy", effect_description: "If 50 percent or more of a character’s total health is dealt in one round they must make a CON by 4 check to stay stable (not enter Unconscious); if 75 percent or more, CON by 2.")

# Character Classes
warrior = CharacterClass.create!(name: "Warrior", description: "A Warrior’s primary focus is damage. They usually prefer class 1 and 3 types of weapons (explained in the weapons section), but are known to make good use out of anything they can get their hands on. Warriors use all types of armor as they vary from savage barbarians who get stronger from massive surges of adrenaline upon becoming hurt to tactical powerhouses who subtly shift their position to allow blows to glance off their heavy armor while dishing out massive damage with maximum prejudice. A Warrior’s passive skills primarily focus on improving their damage (though not so much their accuracy), their damage resistance, and modifying their energy. Their active class skills include such things as incredibly powerful strikes aimed at weapons to disarm, flurries of attacks that have a chance of denying their opponent their next offensive round, and energy manipulation such as sacrificing any defensive allocation to gain additional budget for their offensive allocation.Warriors are recommended to have high Strength and Dexterity.", motto: "The best defense is a good offense!")
soldier = CharacterClass.create!(name: 'Soldier', description: "A Soldier lives and dies by their shield. Often sporting heavy armor and using a variety of weapons (and not uncommonly being trained in more than one) the Soldier’s true strength is in their shield arm. Preferring defense to offense the Soldier strikes when their opponent is off balance, not leaving the safety of their shield unless they know they have a solid advantage. Soldiers are almost never surprised and are nearly always prepared to defend themselves. Soldiers range from being loners who do not trust others to watch their backs to being a team based tank, making shield walls and using formations to avoid the perils of being flanked. A Soldier’s passive skills primarily focus on resistance to negative positioning conditions, improved defense, and combat readiness. Soldier active skills include such things as sacrificing offensive rounds to advance with their shield on defensive rounds in order to catch enemies off balance, taking defensive actions to protect party members instead of or in addition to themselves, and transitioning defense points that never ended up being used into attacks in the following round.", motto: "Perhaps the pen is mightier than the sword, perhaps it isn’t. I do not know. What I can tell you, however, is that the shield is mightier than the sword.")

# Weapon Types
sword = WeaponType.create!(name: "Sword")
light_shield = WeaponType.create!(name: 'Light shield')
heavy_shield = WeaponType.create!(name: 'Heavy shield')
axe = WeaponType.create!(name: 'Axe')
club = WeaponType.create!(name: 'Club')
pick = WeaponType.create!(name: 'War pick')

# Weapons and attack options
battle_axe = Weapon.create!(user_id: core_user.id, weapon_type_id: axe.id, name: 'Battle Axe', description: 'A large, 2 handed axe with heavy cutting power and good reach. A Dane Axe is a good example.', defense_die_number: 1, defense_die_size: 10, flat_defense_bonus: 5, defense_energy_modifier: 1, extra_block_cost: 30, extra_attack_cost: 30, hands_used: 2, dodge_energy_mod_penalty: 0.5)
WeaponClassesWeapon.create!(weapon_class_id: class1.id, weapon_id: battle_axe.id)
b_a_attack1 = AttackOption.create!(name: 'Cleave', description: 'A hard swing to cleave through armor.', weapon_id: battle_axe.id, damage_type_id: bludgeoning_slashing.id, strength_dice: 2, energy_modifier: 2, die_number: 1, die_size: 8, damage_dice: 1, damage_die_size: 6, strength_damage_bonus: 2, flat_damage_bonus: 8)
AttackOptionsCondition.create!(attack_option_id: b_a_attack1.id, condition_id: wounded.id, threshold: 15)
AttackOptionsCondition.create!(attack_option_id: b_a_attack1.id, condition_id: severed_tendon.id, threshold: 30)

war_pick = Weapon.create!(user_id: core_user.id, weapon_type_id: pick.id, name: 'War Pick', description: 'A large, 2 handed haft with a spike protruding from one side at the end. Many war hammers feature such a pick.', defense_die_number: 1, defense_die_size: 10, flat_defense_bonus: 5, defense_energy_modifier: 1, extra_block_cost: 30, extra_attack_cost: 35, hands_used: 2, dodge_energy_mod_penalty: 0.5)
WeaponClassesWeapon.create!(weapon_class_id: class1.id, weapon_id: war_pick.id)
w_p_attack1 = AttackOption.create!(name: 'Impale', description: 'A hard swing to embed the point of the war pick deep into a target.', weapon_id: war_pick.id, damage_type_id: bludgeoning_piercing.id, strength_dice: 2, energy_modifier: 1.5, die_number: 1, die_size: 8, damage_dice: 1, damage_die_size: 10, strength_damage_bonus: 2, flat_damage_bonus: 15)
AttackOptionsCondition.create!(attack_option_id: w_p_attack1.id, condition_id: off_balance.id, threshold: 20)
AttackOptionsCondition.create!(attack_option_id: w_p_attack1.id, condition_id: bleeding.id, threshold: 30)

falchion = Weapon.create!(user_id: core_user.id, weapon_type_id: sword.id, name: 'falchion', description: 'A medium length, slightly curved, broad bladed, heavy sword meant for brutal chops that can cleave through armor and sever limbs.', defense_die_number: 1, defense_die_size: 4, flat_defense_bonus: 5, defense_energy_modifier: 1, extra_block_cost: 30, extra_attack_cost: 27, hands_used: 1)
WeaponClassesWeapon.create!(weapon_class_id: class1.id, weapon_id: falchion.id)
f_attack1 = AttackOption.create!(name: 'Chop', description: 'A hard chop. Falchions are designed to disarm, as in literally remove arms (or legs or heads...).', weapon_id: falchion.id, damage_type_id: bludgeoning_slashing.id, strength_dice: 1, dexterity_dice: 1, energy_modifier: 1.5, die_number: 1, die_size: 8, damage_dice: 1, damage_die_size: 8, strength_damage_bonus: 2, flat_damage_bonus: 12)
AttackOptionsCondition.create!(attack_option_id: f_attack1.id, condition_id: wounded.id, threshold: 12)
AttackOptionsCondition.create!(attack_option_id: f_attack1.id, condition_id: severed_tendon.id, threshold: 25)

hand_axe = Weapon.create!(user_id: core_user.id, weapon_type_id: axe.id, name: 'Hand Axe', description: "A small, one handed axe that can strike with precision and efficiency. Its head heavy nature make its chops surprisingly powerful. Note that this is a weapon of war and it is not a wood chopping tool. It has a narrow and sharp metal head to be lighter and more efficiently wielded.", defense_die_number: 1, defense_die_size: 6, flat_defense_bonus: 5, defense_energy_modifier: 0.5, extra_block_cost: 25, extra_attack_cost: 25, hands_used: 1)
WeaponClassesWeapon.create!(weapon_class_id: class2.id, weapon_id: hand_axe.id)
h_a_attack1 = AttackOption.create!(name: 'Chop', description: 'A quick swing of the axe to bite into flesh or slice through light armor. Not powerful enough to easily make it through anything heavy.', weapon_id: hand_axe.id, damage_type_id: slashing.id, strength_dice: 1, dexterity_dice: 1, energy_modifier: 2, die_number: 1, die_size: 10, damage_dice: 1, damage_die_size: 6, strength_damage_bonus: 4, dexterity_damage_bonus: 6, flat_damage_bonus: 8)
AttackOptionsCondition.create!(attack_option_id: h_a_attack1.id, condition_id: bleeding.id, threshold: 12)
AttackOptionsCondition.create!(attack_option_id: h_a_attack1.id, condition_id: wounded.id, threshold: 20)

mace = Weapon.create!(user_id: core_user.id, weapon_type_id: club.id, name: 'Mace', description: 'A metal weight on the end of a handle maces come in many shapes and sizes. They all specialize in dealing massive impact damage with a head heavy, powerful strike.', defense_die_number: 1, defense_die_size: 4, flat_defense_bonus: 5, defense_energy_modifier: 1, extra_block_cost: 35, extra_attack_cost: 30, hands_used: 1)
WeaponClassesWeapon.create!(weapon_class_id: class1.id, weapon_id: mace.id)
m_attack1 = AttackOption.create!(name: 'Smash', description: 'A brutal swing of the heavy head on a mace. Even if it doesn\'t cave in a skull or break a bone, the shock as it reverberates off your armor will still cause significant damage!', weapon_id: mace.id, damage_type_id: bludgeoning.id, strength_dice: 2, energy_modifier: 1.5, die_number: 1, die_size: 4, damage_dice: 1, damage_die_size: 4, strength_damage_bonus: 2, flat_damage_bonus: 15)
AttackOptionsCondition.create!(attack_option_id: m_attack1.id, condition_id: off_balance.id, threshold: 20)
AttackOptionsCondition.create!(attack_option_id: m_attack1.id, condition_id: broken_bone.id, threshold: 25)

side_sword = Weapon.create!(user_id: core_user.id, weapon_type_id: sword.id, name: 'Side Sword', description: 'A well balanced, straight, tapering sword. Fairly thin and mobile it can both cut and stab fairly well but does not excel in any specific category. It does currently have the best defense of any weapon (excepting shields, which are currently weapons) and is the only weapon with two attack options right now.', defense_die_number: 1, defense_die_size: 6, flat_defense_bonus: 8, defense_energy_modifier: 1.5, extra_block_cost: 25, extra_attack_cost: 25, hands_used: 1)
WeaponClassesWeapon.create!(weapon_class_id: class2.id, weapon_id: side_sword.id)
s_s_attack1 = AttackOption.create!(name: 'Cut', description: 'A quick slice with a nimble weapon. It won\'t cleave through much, but it can certainly wound exposed flesh!', weapon_id: side_sword.id, damage_type_id: slashing.id, dexterity_dice: 2, energy_modifier: 2, die_number: 1, die_size: 6, damage_dice: 1, damage_die_size: 4, strength_damage_bonus: 4, dexterity_damage_bonus: 6, flat_damage_bonus: 8)
AttackOptionsCondition.create!(attack_option_id: s_s_attack1.id, condition_id: bleeding.id, threshold: 8)
AttackOptionsCondition.create!(attack_option_id: s_s_attack1.id, condition_id: wounded.id, threshold: 15)

s_s_attack2 = AttackOption.create!(name: 'Stab', description: 'A thrust with a pointed sword that can easily pass impale an unarmored opponent but might need to find a weak point against any significant armor.', weapon_id: side_sword.id, damage_type_id: piercing.id, dexterity_dice: 2, energy_modifier: 2, die_number: 1, die_size: 6, damage_dice: 1, damage_die_size: 6, strength_damage_bonus: 6, dexterity_damage_bonus: 4, flat_damage_bonus: 4)
AttackOptionsCondition.create!(attack_option_id: s_s_attack2.id, condition_id: bleeding.id, threshold: 12)
AttackOptionsCondition.create!(attack_option_id: s_s_attack2.id, condition_id: wounded.id, threshold: 20)

# Shields
light_shield = Weapon.create!(user_id: core_user.id, weapon_type_id: light_shield.id, name: 'Light Shield', description: 'A small, nimble shield that responds well to energy input but has bad base defense numbers.', defense_die_number: 1, defense_die_size: 10, flat_defense_bonus: 4, defense_energy_modifier: 2, extra_block_cost: 30, hands_used: 1)
WeaponClassesWeapon.create!(weapon_class_id: shields.id, weapon_id: light_shield.id)
AttackOption.create!(name: 'Shield Bash', description: "If in closed in (in same square as target), add 2dSTR and any victory pushes them one square away in the direction you face. Successful attacks also give the following conditions: Narrow: 25 percent reduction of opponent’s next attack energy, Clear: 50 percent reduction, Strong: Attacker is Off Balance, Overwhelming: Attacker is Prone.", weapon_id: light_shield.id, damage_type_id: bludgeoning.id, energy_modifier: 1.5, die_number: 1, die_size: 4, attack_bonus: 10, flat_damage_bonus: 0, damage_dice: 0, damage_die_size: 0)

heavy_shield = Weapon.create!(user_id: core_user.id, weapon_type_id: heavy_shield.id, name: 'Heavy Shield', description: 'A large shield with excellent coverage that responds poorly to energy input but has good base defense numbers.', defense_die_number: 1, defense_die_size: 4, flat_defense_bonus: 15, defense_energy_modifier: 1.5, extra_block_cost: 25, hands_used: 1)
WeaponClassesWeapon.create!(weapon_class_id: shields.id, weapon_id: heavy_shield.id)
AttackOption.create!(name: 'Shield Bash', description: "If in closed in (in same square as target), add 2dSTR and any victory pushes them one square away in the direction you face. Successful attacks also give the following conditions: Narrow: 25 percent reduction of opponent’s next attack energy, Clear: 50 percent reduction, Strong: Attacker is Off Balance, Overwhelming: Attacker is Prone.", weapon_id: heavy_shield.id, damage_type_id: bludgeoning.id, energy_modifier: 1, die_number: 1, die_size: 6, attack_bonus: 15, flat_damage_bonus: 0, damage_dice: 0, damage_die_size: 0)

# Armor
leather_armor = Armor.create!(user_id: core_user.id, name: "Leather Armor", description: "Thick but flexible and light leather fitted into a suit of armor. Substantially more protective than no armor, but won't do much against heavy attacks.", armor_type_id: light_armor.id, passive_defense_bonus: 10, active_action_reduction: 2, budget_reduction: 2, energy_pool_reduction: 10, dodge_die_size_reduction: 2, dodge_energy_mod_penalty: 0)
scale_mail = Armor.create!(user_id: core_user.id, name: "Scale Mail", description: "Small plates of metal that overlap like a dragon's scales. Surprisingly maneuverable for the amount of protection it affords but it's never going to match the truly heavy armors in terms of defensive numbers.", armor_type_id: medium_armor.id, passive_defense_bonus: 15, active_action_reduction: 5, budget_reduction: 4, energy_pool_reduction: 20, dodge_die_size_reduction: 4, dodge_energy_mod_penalty: 0.5)
plate_mail = Armor.create!(user_id: core_user.id, name: "Full Plate Armor", description: "Classic full plate armor. Covering your entire body with sheets of metal makes you incredibly hard to damage but it does affect both your mobility and your vision. It is tiring and hot to fight in full plate, but the defensive boosts are well worth it.", armor_type_id: heavy_armor.id, passive_defense_bonus: 22, active_action_reduction: 8, budget_reduction: 7, energy_pool_reduction: 35, dodge_die_size_reduction: 6, dodge_energy_mod_penalty: 1)

# DR
ldr = [3, 1, 0, 2, 0]
sdr = [8, 6, 4, 5, 2]
pdr = [12, 11, 8, 9, 5]
damage_types = [slashing, piercing, bludgeoning, bludgeoning_slashing, bludgeoning_piercing]
damage_types.each_with_index do |type, idx|
  DamageResistance.create!(armor_id: leather_armor.id, damage_type_id: type.id, amount: ldr[idx])
  DamageResistance.create!(armor_id: scale_mail.id, damage_type_id: type.id, amount: sdr[idx])
  DamageResistance.create!(armor_id: plate_mail.id, damage_type_id: type.id, amount: pdr[idx])
end

# Class Skills
warrior.skills.create!(base_class_skill: true, display_description: true, name: "Always Swinging", description: "If the Warrior uses more energy in their offensive round than in their defensive round, they gain extra energy from their pool to spend on their offensive round. +1 energy at every 10th Skill Points Invested.")
warrior.skills.create!(base_class_skill: true, display_description: true, name: "Thrill of the Fight", description: "When outnumbered (engaged in melee combat with more than one combatant), the Warrior multiplies their bonus from Always Swinging by the number of targets they face. Doesn’t increase pool size. +100 percent per enemy when outnumbered.")

aggression1 = warrior.skills.create!(base_class_skill: false, passive: true, display_description: false, is_weapon_boost: true, weapon_class: class1.id, name: "Aggression (Class 1)", description: "Base Damage increase for a specified weapon class (Class 1). +1 per level.", ranks_available: 8, damage_boost: 1)
[1, 3, 5, 7, 9, 11, 13, 15].each_with_index do |cost, idx|
  aggression1.skill_costs.create!(rank: (idx + 1), cost: cost)
end

aggression2 = warrior.skills.create!(base_class_skill: false, passive: true, display_description: false, is_weapon_boost: true, weapon_class: class2.id, name: "Aggression (Class 2)", description: "Base Damage increase for a specified weapon class (Class 2). +1 per level.", ranks_available: 8, damage_boost: 1)
[1, 3, 5, 7, 9, 11, 13, 15].each_with_index do |cost, idx|
  aggression2.skill_costs.create!(rank: (idx + 1), cost: cost)
end

wild_strikes1 = warrior.skills.create!(base_class_skill: false, passive: true, display_description: false, is_weapon_boost: true, weapon_class: class1.id, name: "Wild Strikes (Class 1)", description: "Damage dice size increase for a specified weapon class (Class 1). +d2 per level.", ranks_available: 7, damage_die_boost: 2)
[2, 3, 5, 8, 13, 21, 34].each_with_index do |cost, idx|
  wild_strikes1.skill_costs.create!(rank: (idx + 1), cost: cost)
end

wild_strikes2 = warrior.skills.create!(base_class_skill: false, passive: true, display_description: false, is_weapon_boost: true, weapon_class: class2.id, name: "Wild Strikes (Class 2)", description: "Damage dice size increase for a specified weapon class (Class 2). +d2 per level.", ranks_available: 7, damage_die_boost: 2)
[2, 3, 5, 8, 13, 21, 34].each_with_index do |cost, idx|
  wild_strikes2.skill_costs.create!(rank: (idx + 1), cost: cost)
end

a_rush = warrior.skills.create!(base_class_skill: false, passive: true, display_description: true, name: "Adrenaline Rush", description: "If the Warrior takes minor injuries (damage without status effect; status effect cancels), they gain a stack of Adrenaline Rush. +2 Energy Budget/+2 Base Damage per stack per level,", ranks_available: 5)
[5,8,13,21, 34].each_with_index do |cost, idx|
  a_rush.skill_costs.create!(rank: (idx + 1), cost: cost)
end

b_s = warrior.skills.create!(base_class_skill: false, passive: true, display_description: true, name: "Battle Sense", description: "If the Warrior is actively engaged with enemies in melee range but out of their line of vision, they may still apply dodge and Glancing Blows defense against attacks from those enemies.", ranks_available: 1)
b_s.skill_costs.create!(rank: 1, cost: 20)

s_a_t_c_r = warrior.skills.create!(base_class_skill: false, passive: true, display_description: false, name: "Swift as the Coursing River", description: "Gain additional attacks at the lowest achieved cost for the given weapon (that is, apply all other skill bonuses). +1 attack possible per level.", ranks_available: 2, bonus_attacks: 1)
[30, 60].each_with_index do |cost, idx|
  s_a_t_c_r.skill_costs.create!(rank: (idx + 1), cost: cost)
end

p_p = warrior.skills.create!(base_class_skill: false, passive: true, display_description: false, name: "Power Proficiency", description: "Class 1 Weapons become more effective in the hands of a skilled Warrior. +1 Base Accuracy/+1 Base Damage per level.", ranks_available: 6, tactical_maneuver_dex_bonus: false, is_weapon_boost: true, weapon_class: 1, damage_boost: 1, accuracy_boost: 1)
[1,3,5,7,9,11].each_with_index do |cost, idx|
  p_p.skill_costs.create!(rank: (idx + 1), cost: cost)
end

f_r = warrior.skills.create!(base_class_skill: false, passive: true, display_description: true, name: "Final Rush", description: "If a Warrior with Final Rush is damaged such that they would normally die (unless the wound actively inhibits their action, such as spinal, brain or tendon damage) the Warrior is allowed 2 extra cycles of combat before they drop.", ranks_available: 1)
[20].each_with_index do |cost, idx|
  f_r.skill_costs.create!(rank: (idx + 1), cost: cost)
end

l_r = warrior.skills.create!(base_class_skill: false, passive: true, display_description: false, name: "Lightning Reflexes", description: "A Warrior adds his Dex Dice to a Tactical Maneuver check made that would result in a Jump Round.", ranks_available: 1, tactical_maneuver_dex_bonus: true)
[20].each_with_index do |cost, idx|
  l_r.skill_costs.create!(rank: (idx + 1), cost: cost)
end

m_g = warrior.skills.create!(base_class_skill: false, display_description: true, name: "Meat Grinder", description: "On killing an enemy, gain a certain amount of energy into the budget from the pool. This energy can be used to attack the enemy directly behind the dead one. Automatic step forward. +50 percent of previous attack, +50 percent to Engage check.", ranks_available: 1)
[10].each_with_index do |cost, idx|
  m_g.skill_costs.create!(rank: (idx + 1), cost: cost)
end

s = warrior.skills.create!(base_class_skill: false, display_description: true, name: "Steamroll", description: "Use 100 percent of round budget in offense to unleash an extra attack at normal cost. If none of the attacks end in defeat for the Warrior, the defender cannot allocate points to their next offensive round.", ranks_available: 1)
[20].each_with_index do |cost, idx|
  s.skill_costs.create!(rank: (idx + 1), cost: cost)
end

b = warrior.skills.create!(base_class_skill: false, display_description: true, name: "Backlash", description: "Upon taking any number of attacks which don’t apply a status effect, the Warrior may unleash a single attack at half again the energy expended during their next offensive round.", ranks_available: 1)
[25].each_with_index do |cost, idx|
  b.skill_costs.create!(rank: (idx + 1), cost: cost)
end

c = warrior.skills.create!(base_class_skill: false, display_description: true, name: "CHAAAARGE!", description: "If the Warrior sprints at maximum speed during their active movement round they may use their entire energy budget in a single attack at half again damage following a successful Engage Check (with a +4 bonus to the TM). Following the attack, the Warrior may make another TM check at +2 to move into their opponent’s square, putting the opponent Off-Balance with a Clear Victory, and knocking them Prone with Strong or Better (use the same margins as in the Jump round).", ranks_available: 1)
[50].each_with_index do |cost, idx|
  c.skill_costs.create!(rank: (idx + 1), cost: cost)
end

m_f = warrior.skills.create!(base_class_skill: false, display_description: true, name: "Measured Ferocity", description: "The Warrior takes a reduction of 2 to his Energy Budget for the next three cycles but gains +4 damage to any attacks made on the fourth cycle (does not stack with itself). The second and third tiers of this skill reduce the number of reduced energy cycles by 1 each upgrade. The final level makes the damage buff last for two cycles.", ranks_available: 4)
[5, 10, 10, 30].each_with_index do |cost, idx|
  m_f.skill_costs.create!(rank: (idx + 1), cost: cost)
end

soldier.skills.create!(base_class_skill: true, display_description: true, name: "Master of Defense", description: "If the Soldier uses more energy in their defensive round than in their offensive round, they gain extra energy from their pool to spend on their defensive round. + 1 energy at every 10th point in the Soldier class.")
soldier.skills.create!(base_class_skill: true, display_description: true, name: "Firm Footing", description: "The Soldier is harder to knock off balance or knock prone. This does not affect their mobility in combat. +1 to defense against the Off Balance and Prone conditions (Margin of Overwhelming Victory and damage conditions) per 10 skill points.")

s_f = soldier.skills.create!(base_class_skill: false, display_description: false, passive: true, name: "Shield Fighter", description: "Soldiers are more effective with shields than anyone else. They gain a flat bonus when defending with a shield. +1 Base Defense per level", ranks_available: 8, is_weapon_boost: true, weapon_class: shields.id, defense_boost: 1)
[1,3,5,7,9,11,13,15].each_with_index do |cost, idx|
  s_f.skill_costs.create!(rank: (idx + 1), cost: cost)
end

b_b = soldier.skills.create!(base_class_skill: false, display_description: false, passive: true, name: "Better Blocker", description: "Increasing dice size by d2 for blocking with a shield per level.", is_weapon_boost: true, weapon_class: shields.id, ranks_available: 7, defense_die_boost: 2)
[2,4,6,8, 10, 12, 14].each_with_index do |cost, idx|
  b_b.skill_costs.create!(rank: (idx + 1), cost: cost)
end

s_w = soldier.skills.create!(base_class_skill: false, display_description: true, passive: true, name: "Shield Wielder", description: "Shield bashes and punches can be executed without canceling the ability for the shield to block in the coming defensive round. Instead, reduce the energy mod on the subsequent defense with the shield by 0.25.", ranks_available: 1)
[15].each_with_index do |cost, idx|
  s_w.skill_costs.create!(rank: (idx + 1), cost: cost)
end

w_o_f = soldier.skills.create!(base_class_skill: false, display_description: false, passive: true, name: "Wall of Force", description: "Adds 0.5 Energy modifier to bashing on a wielded shield.", ranks_available: 1, is_weapon_boost: true, weapon_class: shields.id, attack_energy_mod_boost: 0.5)
[30].each_with_index do |cost, idx|
  w_o_f.skill_costs.create!(rank: (idx + 1), cost: cost)
end

a = soldier.skills.create!(base_class_skill: false, display_description: false, passive: true, name: "Armored", description: "Soldiers have a passive bonus to their armor’s defense. This only applies to attacks within their field of vision. +2 Passive Defense per level.", ranks_available: 8, armor_defense_boost: 2)
[2,4,6,8,10,12,14,16].each_with_index do |cost, idx|
  a.skill_costs.create!(rank: (idx + 1), cost: cost)
end

pha = soldier.skills.create!(base_class_skill: false, display_description: true, passive: true, name: "Phalanx", description: "(Group Skill) If at least two Soldiers in a line with Phalanx are next to each other they both gain a bonus to their shield defense. Does not defend against bull rush checks. +2 Base Defense per adjacent soldier (max 2) per level.", ranks_available: 5)
[3,5,8,13,21].each_with_index do |cost, idx|
  pha.skill_costs.create!(rank: (idx + 1), cost: cost)
end

d_t = soldier.skills.create!(base_class_skill: false, display_description: false, passive: true, name: "Defensive Training", description: "Soldier gains additional blocks at the lowest achieved cost for the given equipment (that is, apply all other skill bonuses), limited to their field of vision. +1 block per weapon per cycle.", ranks_available: 2, bonus_blocks: 1)
[30, 60].each_with_index do |cost, idx|
  d_t.skill_costs.create!(rank: (idx + 1), cost: cost)
end

w_f_t_r_m = soldier.skills.create!(base_class_skill: false, display_description: true, name: "Wait for the Right Moment", description: "If a Soldier spends 3/4 or more of their energy budget in their defensive round, they get a bonus to their chance to inflict positioning errors upon their opponent. Moves Off Balance trigger to Strong then Clear victory.", ranks_available: 2)
[20, 50].each_with_index do |cost, idx|
  w_f_t_r_m.skill_costs.create!(rank: (idx + 1), cost: cost)
end

s_i_t_r_m = soldier.skills.create!(base_class_skill: false, display_description: true, name: "Strike in the Right Moment", description: "If a Soldier using Wait for the Right Moment inflicts a positioning error upon their opponent, they may strike a single blow on their offensive round with a bonus of half the energy used in Wait for the Right Moment.", ranks_available: 1)
[20].each_with_index do |cost, idx|
  s_i_t_r_m.skill_costs.create!(rank: (idx + 1), cost: cost)
end

g = soldier.skills.create!(base_class_skill: false, display_description: true, name: "Guardian", description: "A Soldier with Guardian may use one or more of their blocks for an adjacent ally, though the ally and striking opponent must be in the soldier’s field of vision and be adjacent (they get to choose during their defensive round to whom their blocks are allocated, though each piece of equipment may only be applied to one character).", ranks_available: 1)
[15].each_with_index do |cost, idx|
  g.skill_costs.create!(rank: (idx + 1), cost: cost)
end

b = soldier.skills.create!(base_class_skill: false, display_description: true, name: "Bulwark", description: "Soldier hunkers down, cannot move, and uses his shield to fend off projectiles. Bulwark gives a bonus to defense against physical attack as well, but all energy must be allocated to the defensive round to use Bulwark. Base +10 percent of active defense to passive defense as a bonus, double bonus against projectiles, each level gains +5 percent additional bonus", ranks_available: 6)
[5,8,13,21,34,55].each_with_index do |cost, idx|
  b.skill_costs.create!(rank: (idx + 1), cost: cost)
end

t = soldier.skills.create!(base_class_skill: false, display_description: true, name: "Testudo", description: "You may move one square with Bulwark active during each Movement Round, and can move as one with allied Soldiers with Testudo. Successful TMs result in Jump-margin Shield Bash against the opponent and pushes the opponent back a square.", ranks_available: 1)
[20].each_with_index do |cost, idx|
  t.skill_costs.create!(rank: (idx + 1), cost: cost)
end

k_h_w_h_d = soldier.skills.create!(base_class_skill: false, display_description: true, name: "Kick Him While He’s Down (KHWHD)", description: "If an opponent is off balance or prone the a Soldier with this skill may make an attack at a flat reduced accuracy (-10, -7, -4, -1 after rolling and allocating (though the choice must be made before rolling)) for, if the attack succeeds, a further MoV shift in their favor in addition to the OB/Prone status.", ranks_available: 5)
[25, 10, 5, 5].each_with_index do |cost, idx|
  k_h_w_h_d.skill_costs.create!(rank: (idx + 1), cost: cost)
end

f = soldier.skills.create!(base_class_skill: false, display_description: true, name: "Followup", description: "A Soldier may make an attack with their other hand in addition to a shield bash in one offensive round (using at maximum half of the energy put into the bash). Limited to One-Handed Class 1,2, 7 and 8 weapons. +10 percent energy from bash into the next attack. This can be paired with KHWHD", ranks_available: 5)
[2,4,6,8,10].each_with_index do |cost, idx|
  f.skill_costs.create!(rank: (idx + 1), cost: cost)
end

c_t = soldier.skills.create!(base_class_skill: false, display_description: true, name: "Changing Tides", description: "The Soldier modifies his energy budget for the next four cycles. Cycle 1: -4, Cycle 2: -2, Cycle 3: +2, Cycle 4: +4 (does not stack with itself). Upgrades scale as follows: the first upgrade removes cycle 1, the second adds an additional cycle at the end with +6 energy", ranks_available: 3)
[5, 10, 30].each_with_index do |cost, idx|
  c_t.skill_costs.create!(rank: (idx + 1), cost: cost)
end

# Weapon Skills
class1.skills.create!(base_class_skill: true, display_description: false, passive: true, is_weapon_boost: true, weapon_class: class1.id, name: "Bring the Hurt", description: "For every ten skill points spent on Class 1 weapon skills, all Class 1 weapons gain +2 to damage.", damage_boost: 2)

p_a = class1.skills.create!(base_class_skill: false, display_description: true, name: "Power Attack", description: "Invest more points in offense than defense and gain bonus damage on your attack. If Power Attack is used it must be the only attack in that offensive round. +1 base damage per level.", is_weapon_boost: true, weapon_class: class1.id, ranks_available: 10)
[1,1,2,3,5,8,13,21,34,55].each_with_index do |cost, idx|
  p_a.skill_costs.create!(rank: (idx + 1), cost: cost)
end

s = class1.skills.create!(base_class_skill: false, display_description: true, name: "Sweep", description: "Low angled attack made to knock out the legs. Different margins of victory mean different levels of debuffs from off balance to prone. 1/2 damage on successful attack, Strong victory causes Off Balance, Overwhelming causes Prone. Can’t be used in successive offensive rounds (note that it can be used multiple times within one round).", is_weapon_boost: true, weapon_class: class1.id, ranks_available: 1)
[15].each_with_index do |cost, idx|
  s.skill_costs.create!(rank: (idx + 1), cost: cost)
end

o = class1.skills.create!(base_class_skill: false, display_description: true, name: "Overhead", description: "All opponents gain an accuracy bonus on you during your next defensive round. Deal significantly improved damage and gain a bonus against armor for the hit. Must be used with Power Attack. +25 percent accuracy for enemies, +50 percent total damage before DR.", is_weapon_boost: true, weapon_class: class1.id, ranks_available: 1)
[15].each_with_index do |cost, idx|
  o.skill_costs.create!(rank: (idx + 1), cost: cost)
end

s_u = class1.skills.create!(base_class_skill: false, display_description: true, name: "Step Up", description: "Used with Power Attack and/or Overhead: Take a step forward making an Engage check (Opponent can respond with a step back, if able, by making a Disengage check) and gain a bonus to damage on a power attack. +100 percent damage, put Off Balance in next defensive round.", is_weapon_boost: true, weapon_class: class1.id, ranks_available: 1)
[20].each_with_index do |cost, idx|
  s_u.skill_costs.create!(rank: (idx + 1), cost: cost)
end

d_t = class1.skills.create!(base_class_skill: false, display_description: false, name: "Defensive Training", description: "Gain extra blocks with Class 1 weapons at that weapon’s multiple block cost. (note, Defensive training and Swift do not transfer between classes (not that any skills do…)) +1 block per level.", ranks_available: 2, is_weapon_boost: true, weapon_class: class1.id, bonus_blocks: 1)
[30, 50].each_with_index do |cost, idx|
  d_t.skill_costs.create!(rank: (idx + 1), cost: cost)
end

s = class1.skills.create!(base_class_skill: false, display_description: false, name: "Swift", description: "Gain an additional attack with Class 1 weapons at that weapon’s multiple attack cost.", ranks_available: 1, is_weapon_boost: true, weapon_class: class1.id, bonus_attacks: 1)
[20].each_with_index do |cost, idx|
  s.skill_costs.create!(rank: (idx + 1), cost: cost)
end

s_s = class1.skills.create!(base_class_skill: false, display_description: false, name: "Skilled Striker", description: "The cost for additional attacks with Class 1 weapons is reduced by 2 percent per tier (ex: 35 percent becomes 33 percent).", ranks_available: 3, attack_cost_reduction: 2, is_weapon_boost: true, weapon_class: class1.id)
[10, 20, 30].each_with_index do |cost, idx|
  s_s.skill_costs.create!(rank: (idx + 1), cost: cost)
end

s_b = class1.skills.create!(base_class_skill: false, display_description: false, name: "Skilled Blocker", description: "The cost for additional blocks with Class 1 weapons is reduced by 2 percent per tier (ex: 35 percent becomes 33 percent).", ranks_available: 3, defense_cost_reduction: 2, is_weapon_boost: true, weapon_class: class1.id)
[10, 20, 30].each_with_index do |cost, idx|
  s_b.skill_costs.create!(rank: (idx + 1), cost: cost)
end

class2.skills.create!(base_class_skill: true, passive: true, display_description: false, name: "Balanced Fighter", description: "For every 10 points spent in Class 2 weapons, gain +1 to each attack and defense.", is_weapon_boost: true, weapon_class: class2.id, accuracy_boost: 1, defense_boost: 1)

par = class2.skills.create!(base_class_skill: false, display_description: false, passive: true, name: "Parry", description: "Gain a bonus to defense with a Class 2 weapon. +1 to base defense per level", ranks_available: 7, defense_boost: 1, is_weapon_boost: true, weapon_class: class2.id)
[3,5,8,13,21,34,55].each_with_index do |cost, idx|
  par.skill_costs.create!(rank: (idx + 1), cost: cost)
end

d_t = class2.skills.create!(base_class_skill: false, display_description: false, passive: true, name: "Defensive Training", description: "Gain extra blocks with Class 2 weapons at that weapon’s multiple block cost. +1 block per level ", ranks_available: 2, is_weapon_boost: true, weapon_class: class2.id, bonus_blocks: 1)
[20, 40].each_with_index do |cost, idx|
  d_t.skill_costs.create!(rank: (idx + 1), cost: cost)
end

rip = class2.skills.create!(base_class_skill: false, display_description: true, name: "Riposte", description: "Following a successful block of Clear or higher MoV, Attacks with a Class 2 weapon get a bonus to attack. Clear grants +25 percent next attack total, Strong +50 percent, Overwhelming +100 percent", is_weapon_boost: true, weapon_class: class2.id, ranks_available: 1)
[25].each_with_index do |cost, idx|
  rip.skill_costs.create!(rank: (idx + 1), cost: cost)
end

pre = class2.skills.create!(base_class_skill: false, display_description: false, passive: true, name: "Precision", description: "Bonus to attack with Class 2 weapons. +1 base attack per level", ranks_available: 9, is_weapon_boost: true, weapon_class: class2.id)
[1,2,3,5,8,13,21,34,55].each_with_index do |cost, idx|
  pre.skill_costs.create!(rank: (idx + 1), cost: cost)
end

s = class2.skills.create!(base_class_skill: false, display_description: false, passive: true, name: "Swift", description: "Gain additional attacks with Class 2 weapons at that weapon’s multiple attack cost. +1 attack per level.", ranks_available: 2, bonus_attacks: 1, is_weapon_boost: true, weapon_class: class2.id)
[30, 60].each_with_index do |cost, idx|
  s.skill_costs.create!(rank: (idx + 1), cost: cost)
end

s_s = class2.skills.create!(base_class_skill: false, display_description: false, passive: true, name: "Skilled Striker", description: "The cost for additional attacks with Class 2 weapons is reduced by 3 percent per tier (ex: 25 percent becomes 22 percent).", ranks_available: 3,  attack_cost_reduction: 3, is_weapon_boost: true, weapon_class: class2.id)
[10, 20, 30].each_with_index do |cost, idx|
  s_s.skill_costs.create!(rank: (idx + 1), cost: cost)
end

s_b = class2.skills.create!(base_class_skill: false, display_description: false, passive: true, name: "Skilled Blocker", description: "The cost for additional blocks with Class 2 weapons is reduced by 3 percent per tier (ex: 25 percent becomes 22 percent).", ranks_available: 3, defense_cost_reduction: 2, is_weapon_boost: true, weapon_class: class2.id)
[10, 20, 30].each_with_index do |cost, idx|
  s_b.skill_costs.create!(rank: (idx + 1), cost: cost)
end

l_s = class2.skills.create!(base_class_skill: false, display_description: true, name: "Leap Strike", description: "A quick leap forward to hopefully catch your opponent by surprise. Opponent must make a reflex check in addition to a block check. If the reflex check fails the block is drastically weakened by 50 percent, if the reflex check is made, your accuracy is decreased by 50 percent. Begins at DEXx5, decreases by one per additional level.", is_weapon_boost: true, weapon_class: class2.id, ranks_available: 4)
[4,8,16,32].each_with_index do |cost, idx|
  l_s.skill_costs.create!(rank: (idx + 1), cost: cost)
end



d_t = shields.skills.create!(base_class_skill: false, display_description: false, name: "Defensive Training", description: "Gain extra blocks with shields at that shield's multiple block cost. +1 block per level ", ranks_available: 2, is_weapon_boost: true, weapon_class: shields.id, bonus_blocks: 1)
[20, 40].each_with_index do |cost, idx|
  d_t.skill_costs.create!(rank: (idx + 1), cost: cost)
end

s_b = shields.skills.create!(base_class_skill: false, display_description: false, name: "Skilled Blocker", description: "The cost for additional blocks with shields is reduced by 3 percent per tier (ex: 25 percent becomes 22 percent).", ranks_available: 3, defense_cost_reduction: 2, is_weapon_boost: true, weapon_class: shields.id)
[10, 20, 30].each_with_index do |cost, idx|
  s_b.skill_costs.create!(rank: (idx + 1), cost: cost)
end
