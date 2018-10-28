class CreateEstimates < ActiveRecord::Migration[5.2]
  def change
    create_table :estimates do |t|
      t.belongs_to :users, index: true
      t.string :type
      t.integer :target_year
      t.integer :kenpo_grade
      t.decimal :kenpo_price
      t.decimal :kaigo_price
      t.integer :kosei_grade
      t.decimal :kosei_price
      t.decimal :kikin_price
      t.decimal :koyou_price
      t.decimal :syaho_koujyo
      t.decimal :tax_target_price
      t.decimal :income_tax
      t.decimal :resident_tax
      t.decimal :sum_tax
      t.decimal :lower_limit_fee
      t.decimal :instalment
      t.decimal :new_salary
      t.decimal :tax_economy_result
      t.decimal :kosei_down_annual_income

      t.timestamps
    end
  end
end
