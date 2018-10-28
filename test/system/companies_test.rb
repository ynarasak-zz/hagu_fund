require "application_system_test_case"

class CompaniesTest < ApplicationSystemTestCase
  setup do
    @company = companies(:one)
  end

  test "visiting the index" do
    visit companies_url
    assert_selector "h1", text: "Companies"
  end

  test "creating a Company" do
    visit companies_url
    click_on "New Company"

    fill_in "Interest Rate", with: @company.interest_rate
    fill_in "Kenpo Charge Employee Rate", with: @company.kenpo_charge_employee_rate
    fill_in "Kenpo Kaigo Rate", with: @company.kenpo_kaigo_rate
    fill_in "Kikin Charge Employee Rate", with: @company.kikin_charge_employee_rate
    fill_in "Kosei Rate", with: @company.kosei_rate
    fill_in "Koyou Rate", with: @company.koyou_rate
    fill_in "Min Instalment", with: @company.min_instalment
    fill_in "Monthly Base Work Hour", with: @company.monthly_base_work_hour
    fill_in "Name", with: @company.name
    click_on "Create Company"

    assert_text "Company was successfully created"
    click_on "Back"
  end

  test "updating a Company" do
    visit companies_url
    click_on "Edit", match: :first

    fill_in "Interest Rate", with: @company.interest_rate
    fill_in "Kenpo Charge Employee Rate", with: @company.kenpo_charge_employee_rate
    fill_in "Kenpo Kaigo Rate", with: @company.kenpo_kaigo_rate
    fill_in "Kikin Charge Employee Rate", with: @company.kikin_charge_employee_rate
    fill_in "Kosei Rate", with: @company.kosei_rate
    fill_in "Koyou Rate", with: @company.koyou_rate
    fill_in "Min Instalment", with: @company.min_instalment
    fill_in "Monthly Base Work Hour", with: @company.monthly_base_work_hour
    fill_in "Name", with: @company.name
    click_on "Update Company"

    assert_text "Company was successfully updated"
    click_on "Back"
  end

  test "destroying a Company" do
    visit companies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Company was successfully destroyed"
  end
end
