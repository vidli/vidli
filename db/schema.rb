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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110625234337) do

  create_table "cart_items", :force => true do |t|
    t.integer "cart_id"
    t.integer "video_id"
    t.string  "delivery"
  end

  create_table "carts", :force => true do |t|
    t.string "session_id"
  end

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "s3_path"
    t.string   "screenshot_file_name"
    t.string   "screenshot_content_type"
    t.integer  "screenshot_file_size"
    t.datetime "screenshot_updated_at"
    t.integer  "price_streaming_in_cents"
    t.integer  "price_download_in_cents"
    t.boolean  "downloadable"
    t.boolean  "streamable"
  end

end
