# Users
core_user = User.create!(username: 'Empire: core', email: 'dillonbarevalo@gmail.com', name: 'Dillon and Jack', password: 'donothackme', password_confirmation: 'donothackme')

# Weapon Classes
class1 = WeaponClass.create!(name: 'Power Weapons', description: "These weapons include such things as axes, clubs, and heavy swords. The trees for power weapons are fairly minimal and scale off of strength. These weapons are strong without any skills spent in them with average to high attack and high damage. Type 1 Weapons are wielded with either 1 or 2 hands, depending on the weapon. These weapons are somewhat lacking in defense, but to a low level character, the offensive capabilities they have are simply devastating. The problem with Class 1 weapons is they have few skills to boost their attack and few skills which add meaningful tactical choices, making them scale very poorly into the late game. No matter how high their damage gets, if you can’t hit someone, you can’t hurt them.")
class2 = WeaponClass.create!(name: "Finesse Weapons", description: "Type 2 weapons are one handed weapons that can be wielded by themselves, with another weapon (not yet), or with a shield. These weapons are often difficult to use initially but scale very well when skill points are sunk into them. They scale off of either dexterity and strength, or one of the two. Class 2 weapons have low damage and low attack numbers initially (though they usually have fairly high defensive numbers) but can scale the attack extremely well and damage numbers fairly well. What they lack in early game strength they make up for in both late game strength and the defensive capabilities (especially when coupled with a shield) to get you there.")
shields = WeaponClass.create!(name: 'shields', description: "Ultimately probably won't be a weapon class, but at the moment the website is young enough that I haven't separated them yet. It's a shield, silly.")

# Damage Types
slashing = DamageType.create!(name: 'slashing', description: 'A cut without much impact behind it. Think the cut of a light sword.')
piercing = DamageType.create!(name: 'piercing', description: 'An impact with a sharp weapon, but not one with incredible mass behind it. Think arrow or rapier thrust.')
bludgeoning = DamageType.create!(name: 'bludgeoning', description: 'A heavy impact where no sharp edge is present. Think clubs and hammers.')
bludgeoning_slashing = DamageType.create!(name: 'bludgeoning/slashing', description: 'A heavy impact with an edged weapon. Think large axes or heavy swords. Less of a slice and more of a cleave.')
bludgeoning_piercing = DamageType.create!(name: 'bludgeoning/piercing', description: 'An impact with a sharp point meant to penetrate. Think war picks and half swording.')

# Armor Types
light_armor = ArmorType.create!(name: 'Light')
medium_armor = ArmorType.create!(name: 'Medium')
heavy_armor = ArmorType.create!(name: 'Heavy')

# Conditions
off_balance = Condition.create!(name: "Off Balance", description: "A character has lost their balance and is in danger of falling over.", effect_description: "While off balance, every action that creates a MoV has a shift of -1 to the off balance character applied on it. If an character under the Off Balance condition is knocked off balance a second time that character is knocked prone. Some skills (eventually) will allow execution of maneuvers in off balance positions. Recovery may be made at the beginning of a cycle by sacrificing one’s offensive round, and movement speed is halved.")
prone = Condition.create!(name: "Prone", description: "A character has fallen over! There is not currently (and may never be) a difference between prone (on belly) and supine (on back).", effect_description: "While Prone apply a -2 shift in MoV. Recovery may be attempted at the beginning of a cycle by sacrificing half of one’s energy budget and sacrificing one’s offensive round; no movement be taken save a required Repositioning Check to stand back up (which can incur more MoV shifts upon failure).")
wounded = Condition.create!(name: "Wounded", description: 'A character has an open wound. Movement may tear it and/or cause significant pain. Bleeding is likely to follow.', effect_description: "Using more than 3/4 of round budget used inflicts 1d4 damage per excess point of energy. Heal or significant rest ends. Triggers Bleeding after one cycle. Stacking wounds increases the damage dealt (by 1d4 per energy point) but not the threshold for it. SAVE: roll under CON by 2 (two times your CON stat) to negate.")
severed_tendon = Condition.create!(name: "Severed Tendon", description: "A character has had one of their tendons cut and can no longer control the associated limb at all as they cannot engage their muscles", effect_description: "Triggered during a failed block or dodge (if triggered from Sweep count it as a leg regardless of type of defensive maneuver), where the effect is triggered for the arm that was used to block, or a leg if used for the dodge, and thus can no longer be used. If a leg has a tendon severed movement is halved and sprinting becomes impossible. Also triggers Wounded without Bleeding. If the attack that triggered severed tendon was not blocked or dodged the attacker may choose the limb to damage")
bleeding = Condition.create!(name: "Bleeding", description: "A character has begun bleeding to a significant enough extent that they must pay attention to it.", effect_description: "A bleeding character must spend 10 percent of their energy budget per round on ignoring the wound and staying in combat. Bleeding can stack exactly twice. SAVE: roll under CON by 3 (three times your CON stat) to negate.")
broken_bone = Condition.create!(name: "Broken Bone", description: "A character has broken a bone and cannot use the limb effectively anymore.", effect_description: "Cannot use limbs associated with broken bones without a massive energy drain. If limbs associated with the injury are used anyway, they incur a -1 MoV shift. SAVE: roll under CON by 1 (your CON stat) to negate.")
Condition.create!(name: "Shock", effect_description: "Shock is triggered by any specific weapon but instead by any weapon upon dealing massive damage in a single strike. If 50 percent or more of a character’s total health is dealt in one round they must make a CON by 4 check to stay stable (not enter Unconscious); if 75 percent or more, CON by 2.")

# Character Classes
warrior = CharacterClass.create!(name: "Warrior", description: "A Warrior’s primary focus is damage. They usually prefer class 1 and 3 types of weapons (explained in the weapons section), but are known to make good use out of anything they can get their hands on. Warriors use all types of armor as they vary from savage barbarians who get stronger from massive surges of adrenaline upon becoming hurt to tactical powerhouses who subtly shift their position to allow blows to glance off their heavy armor while dishing out massive damage with maximum prejudice. A Warrior’s passive skills primarily focus on improving their damage (though not so much their accuracy), their damage resistance, and modifying their energy. Their active class skills include such things as incredibly powerful strikes aimed at weapons to disarm, flurries of attacks that have a chance of denying their opponent their next offensive round, and energy manipulation such as sacrificing any defensive allocation to gain additional budget for their offensive allocation.Warriors are recommended to have high Strength and Dexterity.", motto: "The best defense is a good offense!")
soldier = CharacterClass.create!(name: 'Soldier', description: "A Soldier lives and dies by his shield. Often sporting heavy armor and using a variety of weapons (and not uncommonly being trained in more than one) the Soldier’s true strength is in his shield arm. Preferring defense to offense the Soldier strikes when his opponent is off balance, not leaving the safety of his shield unless he knows he has a solid advantage. Soldiers are almost never surprised and are nearly always prepared to defend themselves. Soldiers range from being loners who do not trust others to watch their backs to being a team based tank, making shield walls and using formations to avoid the perils of being flanked. A Soldier’s passive skills primarily focus on resistance to negative positioning conditions, improved defense, and combat readiness. Soldier active skills include such things as sacrificing offensive rounds to advance with their shield on defensive rounds in order to catch enemies off balance, taking defensive actions to protect party members instead of or in addition to themselves, and transitioning defense points that never ended up being used into attacks in the following round.", motto: "Perhaps the pen is mightier than the sword, perhaps it isn’t. I do not know. What I can tell you, however, is that the shield is mightier than the sword.")

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
b_a_attack1 = AttackOption.create!(name: 'Chop', weapon_id: battle_axe.id, damage_type_id: bludgeoning_slashing.id, strength_dice: 2, energy_modifier: 2, die_number: 1, die_size: 8, damage_dice: 1, damage_die_size: 6, strength_damage_bonus: 2, flat_damage_bonus: 8)
AttackOptionsCondition.create!(attack_option_id: b_a_attack1.id, condition_id: wounded.id, threshold: 15)
AttackOptionsCondition.create!(attack_option_id: b_a_attack1.id, condition_id: severed_tendon.id, threshold: 30)

war_pick = Weapon.create!(user_id: core_user.id, weapon_type_id: pick.id, name: 'War Pick', description: 'A large, 2 handed haft with a spike protruding from one side at the end. Many war hammers feature such a pick.', defense_die_number: 1, defense_die_size: 10, flat_defense_bonus: 5, defense_energy_modifier: 1, extra_block_cost: 30, extra_attack_cost: 35, hands_used: 2, dodge_energy_mod_penalty: 0.5)
WeaponClassesWeapon.create!(weapon_class_id: class1.id, weapon_id: war_pick.id)
w_p_attack1 = AttackOption.create!(name: 'Impale', weapon_id: war_pick.id, damage_type_id: bludgeoning_piercing.id, strength_dice: 2, energy_modifier: 1.5, die_number: 1, die_size: 8, damage_dice: 1, damage_die_size: 10, strength_damage_bonus: 2, flat_damage_bonus: 15)
AttackOptionsCondition.create!(attack_option_id: w_p_attack1.id, condition_id: off_balance.id, threshold: 20)
AttackOptionsCondition.create!(attack_option_id: w_p_attack1.id, condition_id: bleeding.id, threshold: 30)

falchion = Weapon.create!(user_id: core_user.id, weapon_type_id: sword.id, name: 'falchion', description: 'A medium length, slightly curved, broad bladed, heavy sword meant for brutal chops that can cleave through armor and sever limbs.', defense_die_number: 1, defense_die_size: 4, flat_defense_bonus: 5, defense_energy_modifier: 1, extra_block_cost: 30, extra_attack_cost: 27, hands_used: 1)
WeaponClassesWeapon.create!(weapon_class_id: class1.id, weapon_id: falchion.id)
f_attack1 = AttackOption.create!(name: 'Chop', weapon_id: falchion.id, damage_type_id: bludgeoning_slashing.id, strength_dice: 1, dexterity_dice: 1, energy_modifier: 1.5, die_number: 1, die_size: 8, damage_dice: 1, damage_die_size: 8, strength_damage_bonus: 2, flat_damage_bonus: 12)
AttackOptionsCondition.create!(attack_option_id: f_attack1.id, condition_id: wounded.id, threshold: 12)
AttackOptionsCondition.create!(attack_option_id: f_attack1.id, condition_id: severed_tendon.id, threshold: 25)

hand_axe = Weapon.create!(user_id: core_user.id, weapon_type_id: axe.id, name: 'Hand Axe', description: "A small, one handed axe that can strike with precision and efficiency. Its head heavy nature make its chops surprisingly powerful.", defense_die_number: 1, defense_die_size: 6, flat_defense_bonus: 5, defense_energy_modifier: 0.5, extra_block_cost: 25, extra_attack_cost: 25, hands_used: 1)
WeaponClassesWeapon.create!(weapon_class_id: class2.id, weapon_id: hand_axe.id)
h_a_attack1 = AttackOption.create!(name: 'Chop', weapon_id: hand_axe.id, damage_type_id: slashing.id, strength_dice: 1, dexterity_dice: 1, energy_modifier: 2, die_number: 1, die_size: 10, damage_dice: 1, damage_die_size: 6, strength_damage_bonus: 4, dexterity_damage_bonus: 6, flat_damage_bonus: 8)
AttackOptionsCondition.create!(attack_option_id: h_a_attack1.id, condition_id: bleeding.id, threshold: 12)
AttackOptionsCondition.create!(attack_option_id: h_a_attack1.id, condition_id: wounded.id, threshold: 20)

mace = Weapon.create!(user_id: core_user.id, weapon_type_id: club.id, name: 'Mace', description: 'A metal weight on the end of a handle maces come in many shapes and sizes. They all specialize in dealing massive impact damage with a head heavy, powerful strike.', defense_die_number: 1, defense_die_size: 4, flat_defense_bonus: 5, defense_energy_modifier: 1, extra_block_cost: 35, extra_attack_cost: 30, hands_used: 1)
WeaponClassesWeapon.create!(weapon_class_id: class1.id, weapon_id: mace.id)
m_attack1 = AttackOption.create!(name: 'Smash', weapon_id: mace.id, damage_type_id: bludgeoning.id, strength_dice: 2, energy_modifier: 1.5, die_number: 1, die_size: 4, damage_dice: 1, damage_die_size: 4, strength_damage_bonus: 2, flat_damage_bonus: 15)
AttackOptionsCondition.create!(attack_option_id: m_attack1.id, condition_id: off_balance.id, threshold: 20)
AttackOptionsCondition.create!(attack_option_id: m_attack1.id, condition_id: broken_bone.id, threshold: 25)

side_sword = Weapon.create!(user_id: core_user.id, weapon_type_id: sword.id, name: 'Side Sword', description: 'A well balanced, straight, tapering sword. Fairly thin and mobile it can both cut and stab fairly well but does not excel in any specific category. It does currently have the best defense of any weapon (excepting shields, which are currently weapons) and is the only weapon with two attack options right now.', defense_die_number: 1, defense_die_size: 6, flat_defense_bonus: 8, defense_energy_modifier: 1.5, extra_block_cost: 25, extra_attack_cost: 25, hands_used: 1)
WeaponClassesWeapon.create!(weapon_class_id: class2.id, weapon_id: side_sword.id)
s_s_attack1 = AttackOption.create!(name: 'Cut', weapon_id: side_sword.id, damage_type_id: slashing.id, dexterity_dice: 2, energy_modifier: 2, die_number: 1, die_size: 6, damage_dice: 1, damage_die_size: 4, strength_damage_bonus: 4, dexterity_damage_bonus: 6, flat_damage_bonus: 8)
AttackOptionsCondition.create!(attack_option_id: s_s_attack1.id, condition_id: bleeding.id, threshold: 8)
AttackOptionsCondition.create!(attack_option_id: s_s_attack1.id, condition_id: wounded.id, threshold: 15)

s_s_attack2 = AttackOption.create!(name: 'Stab', weapon_id: side_sword.id, damage_type_id: piercing.id, dexterity_dice: 2, energy_modifier: 2, die_number: 1, die_size: 6, damage_dice: 1, damage_die_size: 6, strength_damage_bonus: 6, dexterity_damage_bonus: 4, flat_damage_bonus: 4)
AttackOptionsCondition.create!(attack_option_id: s_s_attack2.id, condition_id: bleeding.id, threshold: 12)
AttackOptionsCondition.create!(attack_option_id: s_s_attack2.id, condition_id: wounded.id, threshold: 20)

# Shields
light_shield = Weapon.create!(user_id: core_user.id, weapon_type_id: light_shield.id, name: 'Light Shield', description: 'A small, nimble shield that responds well to energy input but has bad base defense numbers.', defense_die_number: 1, defense_die_size: 10, flat_defense_bonus: 4, defense_energy_modifier: 2, extra_block_cost: 30, hands_used: 1)
WeaponClassesWeapon.create!(weapon_class_id: shields.id, weapon_id: light_shield.id)
AttackOption.create!(name: 'Shield Bash', description: "If in closed in (in same square as target), add 2dSTR and any victory pushes them one square away in the direction you face. Successful attacks also give the following conditions: Narrow: 25 percent reduction of opponent’s next attack energy, Clear: 50 percent reduction, Strong: Attacker is Off Balance, Overwhelming: Attacker is Prone.", weapon_id: light_shield.id, damage_type_id: bludgeoning.id, energy_modifier: 1.5, die_number: 1, die_size: 4, attack_bonus: 10, damage_dice: 0, damage_die_size: 0, strength_damage_bonus: 0, dexterity_damage_bonus: 0, flat_damage_bonus: 0)

heavy_shield = Weapon.create!(user_id: core_user.id, weapon_type_id: heavy_shield.id, name: 'War Pick', description: 'A large shield with excellent coverage that responds poorly to energy input but has good base defense numbers.', defense_die_number: 1, defense_die_size: 4, flat_defense_bonus: 15, defense_energy_modifier: 1.5, extra_block_cost: 25, hands_used: 1)
WeaponClassesWeapon.create!(weapon_class_id: shields.id, weapon_id: heavy_shield.id)
AttackOption.create!(name: 'Shield Bash', description: "If in closed in (in same square as target), add 2dSTR and any victory pushes them one square away in the direction you face. Successful attacks also give the following conditions: Narrow: 25 percent reduction of opponent’s next attack energy, Clear: 50 percent reduction, Strong: Attacker is Off Balance, Overwhelming: Attacker is Prone.", weapon_id: heavy_shield.id, damage_type_id: bludgeoning.id, energy_modifier: 1, die_number: 1, die_size: 6, attack_bonus: 15, damage_dice: 0, damage_die_size: 0, strength_damage_bonus: 0, dexterity_damage_bonus: 0, flat_damage_bonus: 0)

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


# Weapon Skills

