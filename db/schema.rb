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

ActiveRecord::Schema.define(version: 20170424182233) do

  create_table "accounts", force: :cascade do |t|
    t.integer  "budget_id",    limit: 4
    t.string   "name",         limit: 255
    t.string   "account_type", limit: 255
    t.boolean  "archived",                 default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "uuid",         limit: 255
    t.string   "setup_tag",    limit: 255
  end

  add_index "accounts", ["budget_id"], name: "index_accounts_on_budget_id", using: :btree
  add_index "accounts", ["uuid"], name: "index_accounts_on_uuid", using: :btree

  create_table "authie_sessions", force: :cascade do |t|
    t.string   "token",              limit: 255
    t.string   "browser_id",         limit: 255
    t.integer  "user_id",            limit: 4
    t.boolean  "active",                           default: true
    t.text     "data",               limit: 65535
    t.datetime "expires_at"
    t.datetime "login_at"
    t.string   "login_ip",           limit: 255
    t.datetime "last_activity_at"
    t.string   "last_activity_ip",   limit: 255
    t.string   "last_activity_path", limit: 255
    t.string   "user_agent",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_type",          limit: 255
    t.integer  "parent_id",          limit: 4
    t.datetime "two_factored_at"
    t.string   "two_factored_ip",    limit: 255
    t.integer  "requests",           limit: 4,     default: 0
    t.datetime "password_seen_at"
    t.string   "token_hash",         limit: 255
  end

  add_index "authie_sessions", ["browser_id"], name: "index_authie_sessions_on_browser_id", using: :btree
  add_index "authie_sessions", ["token"], name: "index_authie_sessions_on_token", using: :btree
  add_index "authie_sessions", ["token_hash"], name: "index_authie_sessions_on_token_hash", using: :btree
  add_index "authie_sessions", ["user_id"], name: "index_authie_sessions_on_user_id", using: :btree

  create_table "budgets", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "currency",          limit: 255
    t.integer  "user_id",           limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "uuid",              limit: 255
    t.string   "budget_type",       limit: 255
    t.boolean  "example",                       default: false
    t.boolean  "cumulative_totals",             default: true
  end

  add_index "budgets", ["uuid"], name: "index_budgets_on_uuid", using: :btree

  create_table "lines", force: :cascade do |t|
    t.integer  "period_id",           limit: 4
    t.integer  "account_id",          limit: 4
    t.date     "date"
    t.decimal  "amount",                          precision: 8, scale: 2
    t.string   "description",         limit: 255
    t.boolean  "recurring",                                               default: false
    t.integer  "months_to_recur",     limit: 4
    t.integer  "recurring_parent_id", limit: 4
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
    t.string   "uuid",                limit: 255
    t.string   "setup_tag",           limit: 255
  end

  add_index "lines", ["account_id", "period_id"], name: "index_lines_on_account_id_and_period_id", using: :btree
  add_index "lines", ["recurring_parent_id"], name: "index_lines_on_recurring_parent_id", using: :btree
  add_index "lines", ["uuid"], name: "index_lines_on_uuid", using: :btree

  create_table "periods", force: :cascade do |t|
    t.integer  "budget_id",        limit: 4
    t.date     "starts_on"
    t.date     "ends_on"
    t.integer  "length_in_months", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "name",             limit: 255
    t.string   "uuid",             limit: 255
  end

  add_index "periods", ["budget_id"], name: "index_periods_on_budget_id", using: :btree
  add_index "periods", ["uuid"], name: "index_periods_on_uuid", using: :btree

  create_table "setup_values", force: :cascade do |t|
    t.integer  "budget_id",  limit: 4
    t.string   "field",      limit: 255
    t.decimal  "amount",                 precision: 8, scale: 2, default: 0.0
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "email_address",   limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
