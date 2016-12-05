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

ActiveRecord::Schema.define(version: 20161205232129) do

  create_table "evaluations", force: true do |t|
    t.integer  "photo_id",   null: false
    t.integer  "user_id",    null: false
    t.integer  "score",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "evaluations", ["photo_id", "user_id"], name: "index_evaluations_on_photo_id_and_user_id", unique: true

  create_table "photos", force: true do |t|
    t.integer  "shop_id",    null: false
    t.string   "url",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["url"], name: "index_photos_on_url", unique: true

  create_table "shops", id: false, force: true do |t|
    t.integer  "shop_id",    null: false
    t.string   "name",       null: false
    t.decimal  "longitude",  null: false
    t.decimal  "latitude",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password"
  end

  add_index "users", ["id"], name: "index_users_on_id"
  add_index "users", ["name", "password"], name: "index_users_on_name_and_password"

end
