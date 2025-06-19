# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_19_163302) do
  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.string "area_type"
    t.string "game_title"
    t.integer "order_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "boss_battles", force: :cascade do |t|
    t.string "name", null: false
    t.string "boss_type", null: false
    t.string "game_title", null: false
    t.integer "area_id"
    t.integer "level"
    t.text "description"
    t.json "pokemon_data"
    t.text "strategy_notes"
    t.integer "difficulty", default: 1
    t.integer "order_index", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_boss_battles_on_area_id"
    t.index ["game_title", "boss_type"], name: "index_boss_battles_on_game_title_and_boss_type"
    t.index ["game_title", "order_index"], name: "index_boss_battles_on_game_title_and_order_index"
  end

  create_table "challenges", force: :cascade do |t|
    t.string "name"
    t.string "game_title"
    t.integer "status"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_challenges_on_user_id"
  end

  create_table "event_logs", force: :cascade do |t|
    t.integer "challenge_id", null: false
    t.string "event_type", null: false
    t.string "title", null: false
    t.text "description"
    t.json "event_data"
    t.datetime "occurred_at", null: false
    t.integer "pokemon_id"
    t.string "location"
    t.integer "importance", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id", "event_type"], name: "index_event_logs_on_challenge_id_and_event_type"
    t.index ["challenge_id", "occurred_at"], name: "index_event_logs_on_challenge_id_and_occurred_at"
    t.index ["challenge_id"], name: "index_event_logs_on_challenge_id"
    t.index ["occurred_at"], name: "index_event_logs_on_occurred_at"
    t.index ["pokemon_id"], name: "index_event_logs_on_pokemon_id"
  end

  create_table "milestones", force: :cascade do |t|
    t.integer "challenge_id", null: false
    t.string "name", null: false
    t.string "milestone_type", null: false
    t.text "description"
    t.datetime "completed_at"
    t.integer "order_index", default: 0
    t.string "game_area"
    t.boolean "is_required", default: true
    t.json "completion_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id", "milestone_type"], name: "index_milestones_on_challenge_id_and_milestone_type"
    t.index ["challenge_id", "order_index"], name: "index_milestones_on_challenge_id_and_order_index"
    t.index ["challenge_id"], name: "index_milestones_on_challenge_id"
    t.index ["completed_at"], name: "index_milestones_on_completed_at"
  end

  create_table "pokemon_species", force: :cascade do |t|
    t.integer "national_id", null: false
    t.string "name_ja", null: false
    t.string "name_en"
    t.string "name_kana"
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name_en"], name: "index_pokemon_species_on_name_en"
    t.index ["name_ja"], name: "index_pokemon_species_on_name_ja"
    t.index ["national_id"], name: "index_pokemon_species_on_national_id", unique: true
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "nickname"
    t.string "species"
    t.integer "level"
    t.string "nature"
    t.string "ability"
    t.integer "status"
    t.datetime "caught_at"
    t.datetime "died_at"
    t.text "experience"
    t.boolean "in_party"
    t.bigint "challenge_id", null: false
    t.bigint "area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_pokemons_on_area_id"
    t.index ["challenge_id"], name: "index_pokemons_on_challenge_id"
  end

  create_table "rules", force: :cascade do |t|
    t.bigint "challenge_id", null: false
    t.string "name", null: false
    t.text "description"
    t.string "rule_type", null: false
    t.boolean "enabled", default: true
    t.string "default_value"
    t.string "custom_value"
    t.integer "sort_order", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id", "enabled"], name: "index_rules_on_challenge_id_and_enabled"
    t.index ["challenge_id", "rule_type"], name: "index_rules_on_challenge_id_and_rule_type"
    t.index ["challenge_id"], name: "index_rules_on_challenge_id"
  end

  create_table "strategy_guides", force: :cascade do |t|
    t.string "title", null: false
    t.string "guide_type", null: false
    t.string "game_title", null: false
    t.integer "target_boss_id"
    t.text "content", null: false
    t.string "tags"
    t.integer "difficulty", default: 1
    t.string "author"
    t.boolean "is_public", default: true
    t.integer "views_count", default: 0
    t.integer "likes_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_title", "guide_type"], name: "index_strategy_guides_on_game_title_and_guide_type"
    t.index ["guide_type", "difficulty"], name: "index_strategy_guides_on_guide_type_and_difficulty"
    t.index ["is_public"], name: "index_strategy_guides_on_is_public"
    t.index ["target_boss_id"], name: "index_strategy_guides_on_target_boss_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "boss_battles", "areas"
  add_foreign_key "challenges", "users"
  add_foreign_key "event_logs", "challenges"
  add_foreign_key "event_logs", "pokemons"
  add_foreign_key "milestones", "challenges"
  add_foreign_key "pokemons", "areas", on_delete: :nullify
  add_foreign_key "pokemons", "challenges"
  add_foreign_key "rules", "challenges"
  add_foreign_key "strategy_guides", "boss_battles", column: "target_boss_id"
end
