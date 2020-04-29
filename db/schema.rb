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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adjournment_days", force: :cascade do |t|
    t.integer "session_id", null: false
    t.integer "house_id",   null: false
    t.integer "date_id",    null: false
  end

  create_table "dates", force: :cascade do |t|
    t.date "date", null: false
  end

  create_table "dissolution_days", force: :cascade do |t|
    t.integer "prorogation_period_id", null: false
    t.integer "date_id",               null: false
  end

  create_table "dissolution_periods", force: :cascade do |t|
    t.integer "number",   null: false
    t.date    "start_on", null: false
    t.date    "end_on"
  end

  create_table "houses", force: :cascade do |t|
    t.string "name", limit: 50, null: false
  end

  create_table "non_sitting_days", force: :cascade do |t|
    t.integer "session_id", null: false
    t.integer "house_id",   null: false
    t.integer "date_id",    null: false
  end

  create_table "parliament_periods", force: :cascade do |t|
    t.integer "number",   null: false
    t.date    "start_on", null: false
    t.date    "end_on"
  end

  create_table "prorogation_days", force: :cascade do |t|
    t.integer "dissolution_period_id", null: false
    t.integer "date_id",               null: false
  end

  create_table "prorogation_periods", force: :cascade do |t|
    t.integer "number",               null: false
    t.date    "start_on",             null: false
    t.date    "end_on"
    t.integer "parliament_period_id", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "number",               null: false
    t.date    "start_on",             null: false
    t.date    "end_on"
    t.integer "parliament_period_id", null: false
  end

  create_table "sitting_dates", force: :cascade do |t|
    t.integer "sitting_day_id", null: false
    t.integer "date_id",        null: false
  end

  create_table "sitting_days", force: :cascade do |t|
    t.integer "session_id", null: false
    t.integer "house_id",   null: false
  end

  add_foreign_key "adjournment_days", "dates", name: "fk_date"
  add_foreign_key "adjournment_days", "houses", name: "fk_house"
  add_foreign_key "adjournment_days", "sessions", name: "fk_session"
  add_foreign_key "dissolution_days", "dates", name: "fk_date"
  add_foreign_key "dissolution_days", "prorogation_periods", name: "fk_prorogation_period"
  add_foreign_key "non_sitting_days", "dates", name: "fk_date"
  add_foreign_key "non_sitting_days", "houses", name: "fk_house"
  add_foreign_key "non_sitting_days", "sessions", name: "fk_session"
  add_foreign_key "prorogation_days", "dates", name: "fk_date"
  add_foreign_key "prorogation_days", "dissolution_periods", name: "fk_dissolution_period"
  add_foreign_key "prorogation_periods", "parliament_periods", name: "fk_parliament_period"
  add_foreign_key "sessions", "parliament_periods", name: "fk_parliament_period"
  add_foreign_key "sitting_dates", "dates", name: "fk_date"
  add_foreign_key "sitting_dates", "sitting_days", name: "fk_sitting_day"
  add_foreign_key "sitting_days", "houses", name: "fk_house"
  add_foreign_key "sitting_days", "sessions", name: "fk_session"
end
