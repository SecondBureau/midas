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

ActiveRecord::Schema.define(:version => 20120514025604) do

  create_table "accounts", :force => true do |t|
    t.string   "label"
    t.string   "group",      :default => "cash"
    t.string   "currency",   :default => "cny"
    t.boolean  "fyeo",       :default => false
    t.datetime "opened_at"
    t.datetime "closed_at"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "accounts", ["label"], :name => "index_accounts_on_label", :unique => true

  create_table "banks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "label"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "entries", :force => true do |t|
    t.string   "label"
    t.integer  "category_id"
    t.integer  "account_id"
    t.string   "currency"
    t.integer  "src_amount_in_cents", :default => 0
    t.integer  "amount_in_cents",     :default => 0
    t.string   "status"
    t.string   "invoice_num"
    t.string   "cheque_num"
    t.string   "accountant_status"
    t.datetime "operation_date"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "invoice_statuses", :force => true do |t|
    t.string   "label"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "invoices", :force => true do |t|
    t.datetime "date"
    t.integer  "category_id"
    t.integer  "payment_mode_id"
    t.string   "description"
    t.float    "amount"
    t.integer  "invoice_status_id"
    t.string   "cheque_number"
    t.string   "invoice_number"
    t.integer  "to_accountant_id"
    t.integer  "bank_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.float    "rate",              :default => 1.0
  end

  add_index "invoices", ["bank_id"], :name => "index_invoices_on_bank_id"
  add_index "invoices", ["category_id"], :name => "index_invoices_on_category_id"
  add_index "invoices", ["invoice_status_id"], :name => "index_invoices_on_invoice_status_id"
  add_index "invoices", ["payment_mode_id"], :name => "index_invoices_on_payment_mode_id"
  add_index "invoices", ["to_accountant_id"], :name => "index_invoices_on_to_accountant_id"

  create_table "payment_modes", :force => true do |t|
    t.string   "label"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "to_accountants", :force => true do |t|
    t.string   "label"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
