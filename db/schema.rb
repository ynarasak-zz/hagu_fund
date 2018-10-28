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

ActiveRecord::Schema.define(version: 2018_10_28_052738) do

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.float "kenpo_charge_employee_rate"
    t.float "kenpo_kaigo_rate"
    t.float "kosei_rate"
    t.float "kikin_charge_employee_rate"
    t.float "koyou_rate"
    t.float "interest_rate"
    t.float "monthly_base_work_hour"
    t.integer "min_instalment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "income_taxes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "grade"
    t.integer "over"
    t.integer "under"
    t.integer "tax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kenpo_grades", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "grade"
    t.integer "over"
    t.integer "under"
    t.integer "base_monthly_salary"
    t.integer "decision_1_down"
    t.integer "decision_2_down"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kosei_grades", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "grade"
    t.integer "lower_limit"
    t.integer "base_monthly_salary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "systems", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "kosei_down_annual_income_multiplication"
    t.integer "resident_tax_level1_limit"
    t.integer "resident_tax_level2_limit"
    t.decimal "resident_tax_level2_multiplication", precision: 10, scale: 5
    t.integer "resident_tax_level2_addition"
    t.integer "resident_tax_level3_limit"
    t.decimal "resident_tax_level3_multiplication", precision: 10, scale: 5
    t.integer "resident_tax_level3_addition"
    t.integer "resident_tax_level4_limit"
    t.decimal "resident_tax_level4_multiplication", precision: 10, scale: 5
    t.integer "resident_tax_level4_addition"
    t.integer "resident_tax_level5_limit"
    t.decimal "resident_tax_level5_multiplication", precision: 10, scale: 5
    t.integer "resident_tax_level5_addition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
