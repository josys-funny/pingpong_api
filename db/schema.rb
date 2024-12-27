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

ActiveRecord::Schema[8.0].define(version: 2024_12_27_074230) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "match_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "match_id"
    t.integer "team"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_users_on_match_id"
    t.index ["user_id"], name: "index_match_users_on_user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "winner"
    t.integer "type"
    t.integer "first_team_score"
    t.integer "second_team_score"
    t.integer "elo_change"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tournament_id"
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
  end

  create_table "set_tables", force: :cascade do |t|
    t.bigint "match_id"
    t.integer "winner"
    t.integer "first_team_score"
    t.integer "second_team_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_set_tables_on_match_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.integer "format"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "elo"
    t.integer "win_streak"
    t.integer "total_match"
    t.integer "total_win_match"
    t.string "team"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "style"
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "match_users", "matches"
  add_foreign_key "match_users", "users"
  add_foreign_key "matches", "tournaments"
  add_foreign_key "set_tables", "matches"
end
