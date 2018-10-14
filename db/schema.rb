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

ActiveRecord::Schema.define(version: 20181012190915) do

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.integer "code"
    t.integer "decimals"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_currencies_on_code"
  end

  create_table "invoice_statuses", force: :cascade do |t|
    t.string "name"
    t.integer "code"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_invoice_statuses_on_code"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "uuid"
    t.float "price"
    t.float "fees"
    t.string "wallet"
    t.string "txid"
    t.integer "invoice_status_id"
    t.integer "currency_id"
    t.integer "user_id"
    t.integer "temp_user_id"
    t.integer "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["temp_user_id"], name: "index_invoices_on_temp_user_id"
    t.index ["user_id"], name: "index_invoices_on_user_id"
    t.index ["wallet"], name: "index_invoices_on_wallet"
  end

  create_table "matrices", force: :cascade do |t|
    t.string "uuid"
    t.boolean "reedemed", default: false
    t.text "users"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "plan_id"
    t.index ["user_id"], name: "index_matrices_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "price"
    t.float "fees"
    t.integer "expiration_days"
    t.float "daily_percent", default: 0.0
    t.boolean "subscription"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "points", force: :cascade do |t|
    t.integer "user_id"
    t.integer "left_points", default: 0
    t.integer "right_points", default: 0
    t.integer "diff", default: 0
    t.float "max_payment", default: 0.0
    t.integer "left_total_points", default: 0
    t.integer "right_total_points", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_points_on_user_id"
  end

  create_table "reward_statuses", force: :cascade do |t|
    t.string "name"
    t.integer "code"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_reward_statuses_on_code"
  end

  create_table "reward_types", force: :cascade do |t|
    t.string "name"
    t.integer "code"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_reward_types_on_code"
  end

  create_table "rewards", force: :cascade do |t|
    t.string "uuid"
    t.float "value"
    t.integer "reward_type_id"
    t.integer "reward_status_id"
    t.integer "currency_id"
    t.integer "user_id"
    t.integer "subscription_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_id"], name: "index_rewards_on_subscription_id"
    t.index ["user_id"], name: "index_rewards_on_user_id"
  end

  create_table "subscription_statuses", force: :cascade do |t|
    t.string "name"
    t.integer "code"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_subscription_statuses_on_code"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "uuid"
    t.integer "user_id"
    t.integer "plan_id"
    t.integer "invoice_id"
    t.integer "subscription_status_id"
    t.datetime "expiration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "temp_users", force: :cascade do |t|
    t.string "uuid"
    t.string "parent_uuid"
    t.string "username"
    t.boolean "right", default: false
    t.boolean "active"
    t.boolean "admin", default: false
    t.string "name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.string "phone"
    t.string "document"
    t.string "country"
    t.string "city"
    t.string "address"
    t.string "about"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "last_login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_temp_users_on_uuid"
  end

  create_table "users", force: :cascade do |t|
    t.string "uuid"
    t.string "parent_uuid"
    t.string "sponsor_uuid"
    t.boolean "right"
    t.boolean "active"
    t.boolean "left_son"
    t.string "username"
    t.string "name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.string "phone"
    t.string "document"
    t.string "country"
    t.string "city"
    t.string "address"
    t.boolean "withdrawals_enabled", default: true
    t.datetime "confirmed_at"
    t.datetime "last_login"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.integer "ancestry_depth", default: 0
    t.index ["ancestry"], name: "index_users_on_ancestry"
    t.index ["uuid"], name: "index_users_on_uuid"
  end

  create_table "vaults", force: :cascade do |t|
    t.integer "user_id"
    t.float "amount", default: 0.0
    t.float "total_rewards", default: 0.0
    t.float "total_withdrawals", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vaults_on_user_id"
  end

  create_table "withdrawal_statuses", force: :cascade do |t|
    t.string "name"
    t.integer "code"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_withdrawal_statuses_on_code"
  end

  create_table "withdrawal_types", force: :cascade do |t|
    t.string "name"
    t.integer "code"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_withdrawal_types_on_code"
  end

  create_table "withdrawals", force: :cascade do |t|
    t.string "uuid"
    t.integer "user_id"
    t.integer "withdrawal_type_id"
    t.integer "withdrawal_status_id"
    t.float "settle"
    t.float "value"
    t.float "fees"
    t.text "comments"
    t.string "wallet"
    t.integer "currency_id"
    t.string "txid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_withdrawals_on_user_id"
  end

end
