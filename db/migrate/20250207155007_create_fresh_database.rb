class CreateFreshDatabase < ActiveRecord::Migration[7.2]
  def change

    # These are extensions that must be enabled in order to support this database
    enable_extension "pg_catalog.plpgsql"
    enable_extension "pg_stat_statements"

    create_table "adjournment_days", id: :serial, force: :cascade do |t|
      t.date "date", null: false
      t.string "google_event_id", limit: 255, null: false
      t.integer "session_id", null: false
      t.integer "house_id", null: false
      t.integer "recess_date_id"
    end

    create_table "calendar_syncs", id: :integer, default: -> { "nextval('calendar_sync_id_seq'::regclass)" }, force: :cascade do |t|
      t.datetime "synced_at", precision: nil, null: false
    end

    create_table "detailed_sync_logs", force: :cascade do |t|
      t.text "calendar_name"
      t.text "google_calendar_id"
      t.text "message"
      t.boolean "successful"
      t.boolean "emailed"
      t.integer "events_count"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "dissolution_days", id: :serial, force: :cascade do |t|
      t.date "date", null: false
      t.string "google_event_id", limit: 255
      t.integer "dissolution_period_id", null: false
    end

    create_table "dissolution_periods", id: :serial, force: :cascade do |t|
      t.integer "number", null: false
      t.date "start_date", null: false
      t.date "end_date"
    end

    create_table "houses", id: :serial, force: :cascade do |t|
      t.string "name", limit: 50, null: false
    end

    create_table "parliament_periods", id: :serial, force: :cascade do |t|
      t.integer "number", null: false
      t.date "start_date", null: false
      t.date "end_date"
      t.string "wikidata_id", limit: 20
    end

    create_table "procedures", id: :serial, force: :cascade do |t|
      t.integer "display_order", null: false
      t.string "name", limit: 255, null: false
      t.boolean "active", null: false
      t.integer "typical_day_count"
      t.boolean "has_day_count_caveats"
    end

    create_table "prorogation_days", id: :serial, force: :cascade do |t|
      t.date "date", null: false
      t.string "google_event_id", limit: 255
      t.integer "prorogation_period_id", null: false
    end

    create_table "prorogation_periods", id: :serial, force: :cascade do |t|
      t.integer "number", null: false
      t.date "start_date", null: false
      t.date "end_date"
      t.integer "parliament_period_id", null: false
    end

    create_table "recess_dates", id: :serial, force: :cascade do |t|
      t.string "description", limit: 255, null: false
      t.date "start_date", null: false
      t.date "end_date", null: false
      t.string "google_event_id", limit: 255, null: false
      t.integer "house_id", null: false
    end

    create_table "sessions", id: :serial, force: :cascade do |t|
      t.integer "number", null: false
      t.date "start_date", null: false
      t.date "end_date"
      t.string "citation", limit: 255
      t.string "regnal_year_citation", limit: 255
      t.string "wikidata_id", limit: 20
      t.integer "parliament_period_id", null: false
    end

    create_table "sitting_days", id: :serial, force: :cascade do |t|
      t.date "start_date", null: false
      t.date "end_date", null: false
      t.string "google_event_id", limit: 255, null: false
      t.integer "session_id", null: false
      t.integer "house_id", null: false
    end

    create_table "sync_tokens", id: :serial, force: :cascade do |t|
      t.string "google_calendar_id", limit: 255, null: false
      t.string "token", limit: 255, null: false
    end

    create_table "virtual_sitting_days", id: :serial, force: :cascade do |t|
      t.date "start_date", null: false
      t.date "end_date", null: false
      t.string "google_event_id", limit: 255, null: false
      t.integer "session_id", null: false
      t.integer "house_id", null: false
    end

    add_foreign_key "adjournment_days", "houses", name: "fk_house"
    add_foreign_key "adjournment_days", "recess_dates", name: "fk_recess_date"
    add_foreign_key "adjournment_days", "sessions", name: "fk_session"
    add_foreign_key "dissolution_days", "dissolution_periods", name: "fk_dissolution_period"
    add_foreign_key "prorogation_days", "prorogation_periods", name: "fk_prorogation_period"
    add_foreign_key "prorogation_periods", "parliament_periods", name: "fk_parliament_period"
    add_foreign_key "recess_dates", "houses", name: "fk_house"
    add_foreign_key "sessions", "parliament_periods", name: "fk_parliament_period"
    add_foreign_key "sitting_days", "houses", name: "fk_house"
    add_foreign_key "sitting_days", "sessions", name: "fk_session"
    add_foreign_key "virtual_sitting_days", "houses", name: "fk_house"
    add_foreign_key "virtual_sitting_days", "sessions", name: "fk_session"
  end
end
