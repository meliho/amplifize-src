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

ActiveRecord::Schema.define(:version => 20111109060203) do

  create_table "feeds", :force => true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeds", ["url"], :name => "index_feeds_on_url", :unique => true

  create_table "feeds_users", :id => false, :force => true do |t|
    t.integer  "feed_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.time     "created_dt"
    t.text     "content",    :limit => 2147483647
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feed_id"
  end

  add_index "posts", ["feed_id"], :name => "posts_feed_id_fk"

  create_table "posts_users", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.string   "read_state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts_users", ["post_id"], :name => "posts_users_post_id_fk"
  add_index "posts_users", ["user_id"], :name => "posts_users_user_id_fk"

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "posts", "feeds", :name => "posts_feed_id_fk"

  add_foreign_key "posts_users", "posts", :name => "posts_users_post_id_fk"
  add_foreign_key "posts_users", "users", :name => "posts_users_user_id_fk"

end
