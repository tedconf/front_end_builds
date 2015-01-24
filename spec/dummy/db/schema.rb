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

ActiveRecord::Schema.define(version: 20150126123348) do

  create_table "front_end_builds_apps", force: :cascade do |t|
    t.string   "name"
    t.string   "api_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "require_manual_activation", default: false
    t.integer  "live_build_id"
  end

  add_index "front_end_builds_apps", ["api_key"], name: "index_front_end_builds_apps_on_api_key"
  add_index "front_end_builds_apps", ["name"], name: "index_front_end_builds_apps_on_name"

  create_table "front_end_builds_builds", force: :cascade do |t|
    t.integer  "app_id"
    t.string   "sha"
    t.string   "job"
    t.string   "branch"
    t.text     "html"
    t.boolean  "fetched",                 default: false
    t.boolean  "active",                  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "endpoint",   limit: 2038
    t.integer  "pubkey_id"
    t.text     "signature"
  end

  add_index "front_end_builds_builds", ["active"], name: "index_front_end_builds_builds_on_active"
  add_index "front_end_builds_builds", ["app_id", "branch"], name: "index_front_end_builds_builds_on_app_id_and_branch"
  add_index "front_end_builds_builds", ["app_id", "job"], name: "index_front_end_builds_builds_on_app_id_and_job"
  add_index "front_end_builds_builds", ["app_id", "sha"], name: "index_front_end_builds_builds_on_app_id_and_sha"
  add_index "front_end_builds_builds", ["created_at"], name: "index_front_end_builds_builds_on_created_at"
  add_index "front_end_builds_builds", ["fetched"], name: "index_front_end_builds_builds_on_fetched"

  create_table "front_end_builds_pubkeys", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "pubkey",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
