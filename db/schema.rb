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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120816020251) do

  create_table "facebook_accounts", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "active",              :default => false
    t.text     "stream_url"
    t.text     "access_token"
    t.text     "oauth_authorize_url"
    t.datetime "expire_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "foursquare_accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "foursquare_id"
    t.text     "oauth_authorize_url"
    t.text     "access_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "active",              :default => false
  end

  create_table "foursquare_checkins", :force => true do |t|
    t.integer  "foursquare_account_id"
    t.text     "venue_id"
    t.string   "venue_name"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "twitter_accounts", :force => true do |t|
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "user_id"
    t.boolean  "active",               :default => false
    t.text     "stream_url"
    t.string   "oauth_token"
    t.string   "oauth_token_secret"
    t.string   "oauth_token_verifier"
    t.text     "oauth_authorize_url"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
