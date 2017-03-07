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


ActiveRecord::Schema.define(version: 20170306212123) do


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.string   "duration"
    t.text     "description"
    t.integer  "hostel_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["hostel_id"], name: "index_activities_on_hostel_id", using: :btree
  end

  create_table "answers", force: :cascade do |t|
    t.string   "photo"
    t.string   "type"
    t.text     "message"
    t.string   "name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "location"
    t.string   "time"
    t.decimal  "price"
    t.string   "title"
    t.text     "subtitle"
    t.boolean  "quik_replies", default: true, null: false
    t.string   "url"
  end

  create_table "attachinary_files", force: :cascade do |t|
    t.string   "attachinariable_type"
    t.integer  "attachinariable_id"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree
  end

  create_table "bookings", force: :cascade do |t|
    t.date     "checkin"
    t.date     "checkout"
    t.float    "balance"
    t.string   "status"
    t.integer  "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "fb_user_id"
    t.index ["fb_user_id"], name: "index_bookings_on_fb_user_id", using: :btree
    t.index ["room_id"], name: "index_bookings_on_room_id", using: :btree
    t.index ["user_id"], name: "index_bookings_on_user_id", using: :btree
  end

  create_table "fb_users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "profile_pic"
    t.string   "locale"
    t.float    "timezone"
    t.string   "gender"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "fb_id"
    t.integer  "prev_intent_id"
    t.integer  "next_intent_id"
    t.string   "selection"
    t.index ["next_intent_id"], name: "index_fb_users_on_next_intent_id", using: :btree
    t.index ["prev_intent_id"], name: "index_fb_users_on_prev_intent_id", using: :btree
  end

  create_table "hostels", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.text     "information"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "intents", force: :cascade do |t|
    t.integer  "intent_id"
    t.string   "q_string"
    t.string   "q_key"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "answer_id"
    t.string   "type"
    t.string   "field"
    t.boolean  "is_pipeline", default: false, null: false
    t.index ["answer_id"], name: "index_intents_on_answer_id", using: :btree
    t.index ["intent_id"], name: "index_intents_on_intent_id", using: :btree
  end

  create_table "logs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "fb_message_id"
    t.string   "message_type"
    t.datetime "sent_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.integer  "capacity"
    t.text     "description"
    t.integer  "hostel_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.index ["hostel_id"], name: "index_rooms_on_hostel_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "activities", "hostels"
  add_foreign_key "bookings", "fb_users"
  add_foreign_key "bookings", "rooms"
  add_foreign_key "bookings", "users"
  add_foreign_key "intents", "answers"
  add_foreign_key "intents", "intents"
  add_foreign_key "rooms", "hostels"
end
