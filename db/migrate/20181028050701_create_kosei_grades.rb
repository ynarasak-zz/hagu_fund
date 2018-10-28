class CreateKoseiGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :kosei_grades do |t|
      t.integer :grade
      t.integer :lower_limit
      t.integer :base_monthly_salary

      t.timestamps
    end
  end
end
