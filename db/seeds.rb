# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"
System.destroy_all
System.create(
  :kosei_down_annual_income_multiplication => 5.481,
  :resident_tax_level1_limit => 860000,
  :resident_tax_level2_limit => 970000,
  :resident_tax_level2_multiplication => 0.23483,
  :resident_tax_level2_addition => 97350,
  :resident_tax_level3_limit => 1720000,
  :resident_tax_level3_multiplication => 0.33693,
  :resident_tax_level3_addition => 123190,
  :resident_tax_level4_limit => 3550000,
  :resident_tax_level4_multiplication => 0.4084,
  :resident_tax_level4_addition => 375890,
  :resident_tax_level5_limit => 3550000,
  :resident_tax_level5_multiplication => 0.45945,
  :resident_tax_level5_addition => 1123270)

KenpoGrade.destroy_all
CSV.foreach('db/kenpo_grade.csv') do |row|
  KenpoGrade.create(:grade => row[0], :over => row[1], :under => row[2], :base_monthly_salary => row[3], :decision_1_down => [4], :decision_2_down => [5])
end

KoseiGrade.destroy_all
CSV.foreach('db/kosei_grade.csv') do |row|
  KoseiGrade.create(:grade => row[0], :lower_limit => row[1], :base_monthly_salary => row[2])
end


IncomeTax.destroy_all
CSV.foreach('db/income_tax.csv') do |row|
  IncomeTax.create(:grade => row[0], :over => row[1], :under => row[2], :tax => row[3])
end
