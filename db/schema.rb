# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141108234604) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hangman_games", force: true do |t|
    t.integer  "user_id"
    t.string   "word"
    t.string   "guesses"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "game_state"
    t.integer  "num_guesses"
  end

  create_table "tictactoe_games", force: true do |t|
    t.integer  "user_1"
    t.integer  "user_2"
    t.string   "game_state"
    t.string   "last_move"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active?"
  end

  create_table "ttt_player_states", force: true do |t|
    t.integer  "user_id"
    t.integer  "tictactoe_game_id"
    t.boolean  "turn?"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "symbol"
    t.string   "status"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
