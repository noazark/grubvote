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

ActiveRecord::Schema.define(version: 20130723052033) do

  create_table "authentications", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grub_sessions", force: true do |t|
    t.string   "occasion"
    t.string   "token"
    t.integer  "decision_id"
    t.integer  "inviter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invites", force: true do |t|
    t.string   "email"
    t.string   "token"
    t.integer  "grub_session_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invites", ["grub_session_id"], name: "index_invites_on_grub_session_id", using: :btree
  add_index "invites", ["user_id"], name: "index_invites_on_user_id", using: :btree

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "cross_streets"
    t.string   "address"
    t.string   "city"
    t.string   "state_code"
    t.string   "postal_code"
    t.string   "yelp_id"
    t.float    "yelp_rating"
    t.string   "yelp_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", force: true do |t|
    t.integer  "restaurant_id"
    t.integer  "invite_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["invite_id"], name: "index_votes_on_invite_id", using: :btree
  add_index "votes", ["restaurant_id"], name: "index_votes_on_restaurant_id", using: :btree

end
