class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.float :kenpo_charge_employee_rate
      t.float :kenpo_kaigo_rate
      t.float :kosei_rate
      t.float :kikin_charge_employee_rate
      t.float :koyou_rate
      t.float :interest_rate
      t.float :monthly_base_work_hour
      t.integer :min_instalment

      t.timestamps
    end
  end
end
