class CreateSystems < ActiveRecord::Migration[5.2]
  def change
    create_table :systems do |t|
      t.float :kosei_down_annual_income_multiplication
      t.integer :resident_tax_level1_limit
      t.integer :resident_tax_level2_limit
      t.decimal :resident_tax_level2_multiplication
      t.integer :resident_tax_level2_addition
      t.integer :resident_tax_level3_limit
      t.decimal :resident_tax_level3_multiplication
      t.integer :resident_tax_level3_addition
      t.integer :resident_tax_level4_limit
      t.decimal :resident_tax_level4_multiplication
      t.integer :resident_tax_level4_addition
      t.integer :resident_tax_level5_limit
      t.decimal :resident_tax_level5_multiplication
      t.integer :resident_tax_level5_addition

      t.timestamps
    end
  end
end
