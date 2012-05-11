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

ActiveRecord::Schema.define(:version => 20120510074746) do

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

  create_table "to_accountants", :force => true do |t|
    t.string   "label"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
