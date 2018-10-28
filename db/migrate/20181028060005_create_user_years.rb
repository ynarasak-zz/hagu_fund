class CreateUserYears < ActiveRecord::Migration[5.2]
  def change
    create_table :user_years do |t|
      t.belongs_to :users, index: true
      t.integer :april_salary
      t.integer :may_salary
      t.integer :june_salary
      t.integer :nearest_min_salary
      t.date :estimate_age_base_date
      t.integer :age
      t.decimal :average_salary
      t.integer :min_instalment
      t.decimal :sum_salary_10percent
      t.decimal :max_instalment
      t.integer :target_year

      t.timestamps
    end
  end
end
