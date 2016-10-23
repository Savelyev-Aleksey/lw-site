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

ActiveRecord::Schema.define(version: 20161023111759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.datetime "date"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",       limit: 255
    t.integer  "category_id"
    t.index ["category_id"], name: "index_activities_on_category_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string "title", limit: 255
    t.string "color", limit: 255
  end

  create_table "photo_albums", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cover_id"
    t.date     "start_date"
    t.date     "end_date"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "description",          limit: 255
    t.integer  "photo_album_id"
    t.string   "picture_file_name",    limit: 255
    t.string   "picture_content_type", limit: 255
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.index ["photo_album_id"], name: "index_photos_on_photo_album_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "video_albums", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "text",       limit: 255
    t.datetime "date"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["video_id"], name: "index_video_albums_on_video_id", using: :btree
  end

  create_table "videos", force: :cascade do |t|
    t.string   "description",    limit: 255
    t.integer  "video_album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["video_album_id"], name: "index_videos_on_video_album_id", using: :btree
  end

  add_foreign_key "activities", "categories"
end
