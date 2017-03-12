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

ActiveRecord::Schema.define(version: 20170305202431) do

  create_table "cards", force: :cascade do |t|
    t.string  "name"
    t.string  "key"
    t.integer "attack"
    t.integer "defense"
    t.integer "level"
    t.string  "card_type"
    t.string  "attribute_value"
    t.string  "monster_type"
    t.string  "card_effect_type"
    t.string  "property"
  end

  create_table "combos", force: :cascade do |t|
    t.integer "combo_id"
    t.integer "cards_id"
  end

  add_index "combos", ["cards_id"], name: "index_combos_on_cards_id"

  create_table "decks", force: :cascade do |t|
    t.integer "deck_id"
    t.integer "user_id"
  end

  add_index "decks", ["user_id"], name: "index_decks_on_user_id"

  create_table "decks_cards", force: :cascade do |t|
    t.integer "decks_id"
    t.integer "cards_id"
  end

  add_index "decks_cards", ["cards_id"], name: "index_decks_cards_on_cards_id"
  add_index "decks_cards", ["decks_id"], name: "index_decks_cards_on_decks_id"

  create_table "decks_combos", force: :cascade do |t|
    t.integer "combos_id"
    t.integer "decks_id"
  end

  add_index "decks_combos", ["combos_id"], name: "index_decks_combos_on_combos_id"
  add_index "decks_combos", ["decks_id"], name: "index_decks_combos_on_decks_id"

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
