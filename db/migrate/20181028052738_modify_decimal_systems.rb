class ModifyDecimalSystems < ActiveRecord::Migration[5.2]
  def change
    change_column :systems, :resident_tax_level2_multiplication, :decimal, precision: 10, scale: 5
    change_column :systems, :resident_tax_level3_multiplication, :decimal, precision: 10, scale: 5
    change_column :systems, :resident_tax_level4_multiplication, :decimal, precision: 10, scale: 5
    change_column :systems, :resident_tax_level5_multiplication, :decimal, precision: 10, scale: 5
  end
end
