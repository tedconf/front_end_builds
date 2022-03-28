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

ActiveRecord::Schema.define(version: 2015_02_24_040537) do

  create_table "front_end_builds_apps", force: :cascade do |t|
    t.string "name", limit: 191
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "require_manual_activation", default: false
    t.integer "live_build_id"
    t.index ["name"], name: "index_front_end_builds_apps_on_name"
  end

  create_table "front_end_builds_builds", force: :cascade do |t|
    t.integer "app_id"
    t.string "sha", limit: 191
    t.string "job", limit: 191
    t.string "branch", limit: 191
    t.text "html"
    t.boolean "fetched", default: false
    t.boolean "active", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "endpoint", limit: 2038
    t.integer "pubkey_id"
    t.text "signature"
    t.index ["active"], name: "index_front_end_builds_builds_on_active"
    t.index ["app_id", "branch"], name: "index_front_end_builds_builds_on_app_id_and_branch"
    t.index ["app_id", "job"], name: "index_front_end_builds_builds_on_app_id_and_job"
    t.index ["app_id", "sha"], name: "index_front_end_builds_builds_on_app_id_and_sha"
    t.index ["created_at"], name: "index_front_end_builds_builds_on_created_at"
    t.index ["fetched"], name: "index_front_end_builds_builds_on_fetched"
  end

  create_table "front_end_builds_pubkeys", force: :cascade do |t|
    t.string "name", limit: 191, null: false
    t.text "pubkey", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
