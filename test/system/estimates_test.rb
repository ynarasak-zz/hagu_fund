require "application_system_test_case"

class EstimatesTest < ApplicationSystemTestCase
  setup do
    @estimate = estimates(:one)
  end

  test "visiting the index" do
    visit estimates_url
    assert_selector "h1", text: "Estimates"
  end

  test "creating a Estimate" do
    visit estimates_url
    click_on "New Estimate"

    fill_in "Income Tax", with: @estimate.income_tax
    fill_in "Instalment", with: @estimate.instalment
    fill_in "Kaigo Price", with: @estimate.kaigo_price
    fill_in "Kenpo Grade", with: @estimate.kenpo_grade
    fill_in "Kenpo Price", with: @estimate.kenpo_price
    fill_in "Kikin Price", with: @estimate.kikin_price
    fill_in "Kosei Down Annual Income", with: @estimate.kosei_down_annual_income
    fill_in "Kosei Grade", with: @estimate.kosei_grade
    fill_in "Kosei Price", with: @estimate.kosei_price
    fill_in "Koyou Price", with: @estimate.koyou_price
    fill_in "Lower Limit Fee", with: @estimate.lower_limit_fee
    fill_in "New Salary", with: @estimate.new_salary
    fill_in "Resident Tax", with: @estimate.resident_tax
    fill_in "Sum Tax", with: @estimate.sum_tax
    fill_in "Syaho Koujyo", with: @estimate.syaho_koujyo
    fill_in "Target Year", with: @estimate.target_year
    fill_in "Tax Economy Result", with: @estimate.tax_economy_result
    fill_in "Tax Target Price", with: @estimate.tax_target_price
    fill_in "Type", with: @estimate.type
    click_on "Create Estimate"

    assert_text "Estimate was successfully created"
    click_on "Back"
  end

  test "updating a Estimate" do
    visit estimates_url
    click_on "Edit", match: :first

    fill_in "Income Tax", with: @estimate.income_tax
    fill_in "Instalment", with: @estimate.instalment
    fill_in "Kaigo Price", with: @estimate.kaigo_price
    fill_in "Kenpo Grade", with: @estimate.kenpo_grade
    fill_in "Kenpo Price", with: @estimate.kenpo_price
    fill_in "Kikin Price", with: @estimate.kikin_price
    fill_in "Kosei Down Annual Income", with: @estimate.kosei_down_annual_income
    fill_in "Kosei Grade", with: @estimate.kosei_grade
    fill_in "Kosei Price", with: @estimate.kosei_price
    fill_in "Koyou Price", with: @estimate.koyou_price
    fill_in "Lower Limit Fee", with: @estimate.lower_limit_fee
    fill_in "New Salary", with: @estimate.new_salary
    fill_in "Resident Tax", with: @estimate.resident_tax
    fill_in "Sum Tax", with: @estimate.sum_tax
    fill_in "Syaho Koujyo", with: @estimate.syaho_koujyo
    fill_in "Target Year", with: @estimate.target_year
    fill_in "Tax Economy Result", with: @estimate.tax_economy_result
    fill_in "Tax Target Price", with: @estimate.tax_target_price
    fill_in "Type", with: @estimate.type
    click_on "Update Estimate"

    assert_text "Estimate was successfully updated"
    click_on "Back"
  end

  test "destroying a Estimate" do
    visit estimates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Estimate was successfully destroyed"
  end
end
