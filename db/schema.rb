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

ActiveRecord::Schema[7.0].define(version: 2024_10_21_202142) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "messages", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_messages_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wind_turbine_readings", force: :cascade do |t|
    t.datetime "time", null: false
    t.float "temp_2m"
    t.float "relhum_2m"
    t.float "dp_2m"
    t.float "ws_10m"
    t.float "ws_100m"
    t.float "wd_10m"
    t.float "wd_100m"
    t.float "wg_10m"
    t.float "actual_power_output"
    t.float "forecasted_power_output"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actual_power_output"], name: "index_wind_turbine_readings_on_actual_power_output"
    t.index ["forecasted_power_output"], name: "index_wind_turbine_readings_on_forecasted_power_output"
    t.index ["time"], name: "index_wind_turbine_readings_on_time"
  end

  add_foreign_key "messages", "rooms"
end
