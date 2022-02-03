# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_24_011552) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bank_loans", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "bank_id"
    t.string "loan_type"
    t.float "requested_amount"
    t.float "payment_amount"
    t.float "interest_amount"
    t.integer "total_installments"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bank_id"], name: "index_bank_loans_on_bank_id"
    t.index ["client_id"], name: "index_bank_loans_on_client_id"
  end

  create_table "banks", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "cnpj"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "birth_date"
    t.string "cpf"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "loan_installments", force: :cascade do |t|
    t.bigint "bank_loan_id"
    t.datetime "due_date"
    t.float "value"
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bank_loan_id"], name: "index_loan_installments_on_bank_loan_id"
  end

  add_foreign_key "bank_loans", "banks"
  add_foreign_key "bank_loans", "clients"
  add_foreign_key "loan_installments", "bank_loans"
end
