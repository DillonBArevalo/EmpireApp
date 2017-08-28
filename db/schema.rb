# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170716043007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "armor_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "armors", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.integer  "armor_type_id"
    t.integer  "passive_defense_bonus"
    t.integer  "active_action_reduction"
    t.integer  "budget_reduction"
    t.integer  "energy_pool_reduction"
    t.decimal  "dodge_energy_mod_penalty"
    t.integer  "dodge_die_size_reduction"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["armor_type_id"], name: "index_armors_on_armor_type_id", using: :btree
    t.index ["user_id"], name: "index_armors_on_user_id", using: :btree
  end

  create_table "attack_options", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "weapon_id"
    t.integer  "damage_type_id"
    t.integer  "strength_dice",          default: 0
    t.integer  "dexterity_dice",         default: 0
    t.decimal  "energy_modifier"
    t.integer  "die_number"
    t.integer  "die_size"
    t.integer  "attack_bonus",           default: 0
    t.integer  "damage_dice"
    t.integer  "damage_die_size"
    t.integer  "strength_damage_bonus"
    t.integer  "dexterity_damage_bonus"
    t.integer  "flat_damage_bonus"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["damage_type_id"], name: "index_attack_options_on_damage_type_id", using: :btree
    t.index ["weapon_id"], name: "index_attack_options_on_weapon_id", using: :btree
  end

  create_table "attack_options_conditions", force: :cascade do |t|
    t.integer  "attack_option_id"
    t.integer  "condition_id"
    t.integer  "threshold"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["attack_option_id"], name: "index_attack_options_conditions_on_attack_option_id", using: :btree
    t.index ["condition_id"], name: "index_attack_options_conditions_on_condition_id", using: :btree
  end

  create_table "character_classes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "motto"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "characters", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "equipped_armor_id"
    t.string   "name"
    t.text     "description"
    t.integer  "strength"
    t.integer  "dexterity"
    t.integer  "constitution"
    t.integer  "intelligence"
    t.integer  "wisdom"
    t.integer  "charisma"
    t.integer  "energy_budget_level_bonus",     default: 0
    t.integer  "energy_pool_level_bonus",       default: 0
    t.integer  "total_skill_points",            default: 0
    t.integer  "available_skill_points",        default: 0
    t.integer  "unspent_energy_upgrade_points", default: 0
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["equipped_armor_id"], name: "index_characters_on_equipped_armor_id", using: :btree
    t.index ["user_id"], name: "index_characters_on_user_id", using: :btree
  end

  create_table "conditions", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "effect_description"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "damage_resistances", force: :cascade do |t|
    t.integer  "armor_id"
    t.integer  "damage_type_id"
    t.integer  "amount"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["armor_id"], name: "index_damage_resistances_on_armor_id", using: :btree
    t.index ["damage_type_id"], name: "index_damage_resistances_on_damage_type_id", using: :btree
  end

  create_table "damage_types", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "equipped_weapons", force: :cascade do |t|
    t.integer  "weapon_id"
    t.integer  "character_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["character_id"], name: "index_equipped_weapons_on_character_id", using: :btree
    t.index ["weapon_id"], name: "index_equipped_weapons_on_weapon_id", using: :btree
  end

  create_table "inventories", force: :cascade do |t|
    t.integer  "character_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["character_id"], name: "index_inventories_on_character_id", using: :btree
  end

  create_table "obtained_armors", force: :cascade do |t|
    t.integer  "inventory_id"
    t.integer  "armor_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["armor_id"], name: "index_obtained_armors_on_armor_id", using: :btree
    t.index ["inventory_id"], name: "index_obtained_armors_on_inventory_id", using: :btree
  end

  create_table "obtained_character_classes", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "character_class_id"
    t.integer  "invested_points"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["character_class_id"], name: "index_obtained_character_classes_on_character_class_id", using: :btree
    t.index ["character_id"], name: "index_obtained_character_classes_on_character_id", using: :btree
  end

  create_table "obtained_skills", force: :cascade do |t|
    t.integer  "skill_id"
    t.integer  "character_id"
    t.integer  "applicable_weapon_class_id"
    t.integer  "ranks"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["applicable_weapon_class_id"], name: "index_obtained_skills_on_applicable_weapon_class_id", using: :btree
    t.index ["character_id"], name: "index_obtained_skills_on_character_id", using: :btree
    t.index ["skill_id"], name: "index_obtained_skills_on_skill_id", using: :btree
  end

  create_table "obtained_weapons", force: :cascade do |t|
    t.integer  "weapon_id"
    t.integer  "inventory_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["inventory_id"], name: "index_obtained_weapons_on_inventory_id", using: :btree
    t.index ["weapon_id"], name: "index_obtained_weapons_on_weapon_id", using: :btree
  end

  create_table "skill_costs", force: :cascade do |t|
    t.integer  "skill_id"
    t.integer  "rank"
    t.integer  "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_skill_costs_on_skill_id", using: :btree
  end

  create_table "skills", force: :cascade do |t|
    t.boolean  "base_class_skill",            default: false
    t.boolean  "display_description",         default: true
    t.string   "skillable_type"
    t.integer  "skillable_id"
    t.string   "name"
    t.text     "description"
    t.boolean  "passive",                     default: false
    t.boolean  "tactical_maneuver_dex_bonus", default: false
    t.boolean  "is_weapon_boost",             default: false
    t.integer  "weapon_class"
    t.integer  "ranks_available",             default: 1
    t.integer  "damage_boost",                default: 0
    t.integer  "damage_die_boost",            default: 0
    t.integer  "accuracy_boost",              default: 0
    t.integer  "defense_boost",               default: 0
    t.integer  "defense_die_boost",           default: 0
    t.integer  "armor_defense_boost",         default: 0
    t.integer  "bonus_attacks",               default: 0
    t.integer  "bonus_blocks",                default: 0
    t.decimal  "attack_energy_mod_boost",     default: "0.0"
    t.integer  "attack_cost_reduction",       default: 0
    t.integer  "defense_cost_reduction",      default: 0
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.index ["skillable_type", "skillable_id"], name: "index_skills_on_skillable_type_and_skillable_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "weapon_classes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "weapon_classes_weapons", force: :cascade do |t|
    t.integer  "weapon_class_id"
    t.integer  "weapon_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["weapon_class_id"], name: "index_weapon_classes_weapons_on_weapon_class_id", using: :btree
    t.index ["weapon_id"], name: "index_weapon_classes_weapons_on_weapon_id", using: :btree
  end

  create_table "weapon_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weapons", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "weapon_type_id"
    t.string   "name"
    t.text     "description"
    t.integer  "defense_die_number"
    t.integer  "defense_die_size"
    t.integer  "flat_defense_bonus"
    t.decimal  "defense_energy_modifier"
    t.integer  "extra_attack_cost"
    t.integer  "extra_block_cost"
    t.integer  "hands_used"
    t.decimal  "dodge_energy_mod_penalty", default: "0.0"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["user_id"], name: "index_weapons_on_user_id", using: :btree
    t.index ["weapon_type_id"], name: "index_weapons_on_weapon_type_id", using: :btree
  end

end
