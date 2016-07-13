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

ActiveRecord::Schema.define(version: 20160712200626) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer  "season_id",    null: false
    t.integer  "week",         null: false
    t.integer  "away_team_id", null: false
    t.float    "away_score"
    t.integer  "home_team_id", null: false
    t.float    "home_score"
    t.string   "game_type",    null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["away_team_id"], name: "index_games_on_away_team_id", using: :btree
    t.index ["home_team_id"], name: "index_games_on_home_team_id", using: :btree
  end

  create_table "leagues", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "owners", force: :cascade do |t|
    t.string   "first_name", null: false
    t.string   "last_name",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "records", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seasons", force: :cascade do |t|
    t.integer  "year",       null: false
    t.integer  "league_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "season_id",  null: false
    t.string   "name",       null: false
    t.integer  "owner_id",   null: false
    t.string   "division",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_teams_on_owner_id", using: :btree
    t.index ["season_id"], name: "index_teams_on_season_id", using: :btree
  end

end
