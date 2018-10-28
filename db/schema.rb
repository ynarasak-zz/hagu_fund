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

ActiveRecord::Schema.define(version: 2018_10_28_131810) do

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

  create_table "estimates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "users_id"
    t.string "estimate_type"
    t.integer "target_year"
    t.integer "kenpo_grade"
    t.decimal "kenpo_price", precision: 10
    t.decimal "kaigo_price", precision: 10
    t.integer "kosei_grade"
    t.decimal "kosei_price", precision: 10
    t.decimal "kikin_price", precision: 10
    t.decimal "koyou_price", precision: 10
    t.decimal "syaho_koujyo", precision: 10
    t.decimal "tax_target_price", precision: 10
    t.decimal "income_tax", precision: 10
    t.decimal "resident_tax", precision: 10
    t.decimal "sum_tax", precision: 10
    t.decimal "lower_limit_fee", precision: 10
    t.decimal "instalment", precision: 10
    t.decimal "new_salary", precision: 10
    t.decimal "tax_economy_result", precision: 10
    t.decimal "kosei_down_annual_income", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["users_id"], name: "index_estimates_on_users_id"
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

  create_table "user_years", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "users_id"
    t.integer "april_salary"
    t.integer "may_salary"
    t.integer "june_salary"
    t.integer "nearest_min_salary"
    t.date "estimate_age_base_date"
    t.integer "age"
    t.decimal "average_salary", precision: 10
    t.integer "min_instalment"
    t.decimal "sum_salary_20percent", precision: 10
    t.decimal "max_instalment", precision: 10
    t.integer "target_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["users_id"], name: "index_user_years_on_users_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "companies_id"
    t.integer "no"
    t.string "code"
    t.string "organization"
    t.string "name"
    t.date "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["companies_id"], name: "index_users_on_companies_id"
  end

end
