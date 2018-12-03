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

ActiveRecord::Schema.define(version: 2018_12_02_211259) do

  create_table "expense_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "user_uid", limit: 25, null: false
    t.string "base_currency", limit: 10, default: "usd", null: false
    t.decimal "month_expenses", precision: 12, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "user_uid"], name: "index_expense_categories_on_name_and_user_uid", unique: true
  end

  create_table "expenses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description"
    t.bigint "keep_account_id"
    t.bigint "expense_category_id"
    t.datetime "recorded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_category_id"], name: "index_expenses_on_expense_category_id"
    t.index ["keep_account_id"], name: "index_expenses_on_keep_account_id"
  end

  create_table "incomes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description"
    t.bigint "keep_account_id"
    t.datetime "recorded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["keep_account_id"], name: "index_incomes_on_keep_account_id"
  end

  create_table "keep_accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "user_uid", limit: 25, null: false
    t.string "base_currency", limit: 10, default: "usd", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "user_uid"], name: "index_keep_accounts_on_name_and_user_uid", unique: true
  end

  create_table "operations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "account_type", null: false
    t.bigint "account_id", null: false
    t.string "parent_type", null: false
    t.bigint "parent_id", null: false
    t.decimal "debit", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "credit", precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "recorded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_type", "account_id"], name: "index_operations_on_account_type_and_account_id"
    t.index ["parent_type", "parent_id"], name: "index_operations_on_parent_type_and_parent_id"
  end

end
