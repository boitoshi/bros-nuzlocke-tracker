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

ActiveRecord::Schema[8.0].define(version: 2025_06_19_080320) do
  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.string "area_type"
    t.string "game_title"
    t.integer "order_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "challenges", "users"
  add_foreign_key "pokemons", "areas", on_delete: :nullify
  add_foreign_key "pokemons", "challenges"
  add_foreign_key "rules", "challenges"
end
