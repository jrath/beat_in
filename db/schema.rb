# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 5) do

  create_table "beats", :force => true do |t|
    t.string   "content",    :limit => 150
    t.integer  "user_id",                   :null => false
    t.datetime "created_at"
  end

  add_index "beats", ["user_id"], :name => "index_beats_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer "source_beat_id"
    t.integer "comment_beat_id"
  end

  add_index "comments", ["comment_beat_id"], :name => "index_comments_on_comment_beat_id"
  add_index "comments", ["source_beat_id"], :name => "index_comments_on_source_beat_id"

  create_table "follows", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followee_id"], :name => "index_follows_on_followee_id"
  add_index "follows", ["follower_id"], :name => "index_follows_on_follower_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40,                  :null => false
    t.string   "name",                      :limit => 100, :default => "", :null => false
    t.string   "email",                     :limit => 100,                 :null => false
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
