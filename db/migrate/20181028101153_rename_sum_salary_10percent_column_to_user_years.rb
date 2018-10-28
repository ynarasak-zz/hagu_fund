class RenameSumSalary10percentColumnToUserYears < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_years, :sum_salary_10percent, :sum_salary_20percent
  end
end
