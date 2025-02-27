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

ActiveRecord::Schema[8.0].define(version: 2025_02_26_081715) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "match_sets", force: :cascade do |t|
    t.bigint "match_id"
    t.integer "winner", default: 0
    t.integer "first_team_score", default: 0
    t.integer "second_team_score", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["match_id"], name: "index_match_sets_on_match_id"
  end

  create_table "match_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "match_id"
    t.integer "team_side", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "elo", default: 1000, null: false
    t.index ["match_id"], name: "index_match_users_on_match_id"
    t.index ["user_id"], name: "index_match_users_on_user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "winner", default: 0
    t.integer "match_type", default: 0
    t.integer "first_team_score", default: 0
    t.integer "second_team_score", default: 0
    t.integer "elo_change", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tournament_id"
    t.integer "best_of", default: 1
    t.integer "status", default: 0
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.integer "format", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "elo", default: 1200
    t.integer "win_streak", default: 0
    t.integer "total_match", default: 0
    t.integer "total_win_match", default: 0
    t.string "team", default: "Josys", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "style", default: 0
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "match_sets", "matches"
  add_foreign_key "match_users", "matches"
  add_foreign_key "match_users", "users"
  add_foreign_key "matches", "tournaments"
end
