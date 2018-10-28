class CreateKenpoGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :kenpo_grades do |t|
      t.integer :grade
      t.integer :over
      t.integer :under
      t.integer :base_monthly_salary
      t.integer :decision_1_down
      t.integer :decision_2_down

      t.timestamps
    end
  end
end
