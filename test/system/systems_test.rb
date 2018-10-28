require "application_system_test_case"

class SystemsTest < ApplicationSystemTestCase
  setup do
    @system = systems(:one)
  end

  test "visiting the index" do
    visit systems_url
    assert_selector "h1", text: "Systems"
  end

  test "creating a System" do
    visit systems_url
    click_on "New System"

    fill_in "Kosei Down Annual Income Multiplication", with: @system.kosei_down_annual_income_multiplication
    fill_in "Resident Tax Level1 Limit", with: @system.resident_tax_level1_limit
    fill_in "Resident Tax Level2 Addition", with: @system.resident_tax_level2_addition
    fill_in "Resident Tax Level2 Limit", with: @system.resident_tax_level2_limit
    fill_in "Resident Tax Level2 Multiplication", with: @system.resident_tax_level2_multiplication
    fill_in "Resident Tax Level3 Addition", with: @system.resident_tax_level3_addition
    fill_in "Resident Tax Level3 Limit", with: @system.resident_tax_level3_limit
    fill_in "Resident Tax Level3 Multiplication", with: @system.resident_tax_level3_multiplication
    fill_in "Resident Tax Level4 Addition", with: @system.resident_tax_level4_addition
    fill_in "Resident Tax Level4 Limit", with: @system.resident_tax_level4_limit
    fill_in "Resident Tax Level4 Multiplication", with: @system.resident_tax_level4_multiplication
    fill_in "Resident Tax Level5 Addition", with: @system.resident_tax_level5_addition
    fill_in "Resident Tax Level5 Limit", with: @system.resident_tax_level5_limit
    fill_in "Resident Tax Level5 Multiplication", with: @system.resident_tax_level5_multiplication
    click_on "Create System"

    assert_text "System was successfully created"
    click_on "Back"
  end

  test "updating a System" do
    visit systems_url
    click_on "Edit", match: :first

    fill_in "Kosei Down Annual Income Multiplication", with: @system.kosei_down_annual_income_multiplication
    fill_in "Resident Tax Level1 Limit", with: @system.resident_tax_level1_limit
    fill_in "Resident Tax Level2 Addition", with: @system.resident_tax_level2_addition
    fill_in "Resident Tax Level2 Limit", with: @system.resident_tax_level2_limit
    fill_in "Resident Tax Level2 Multiplication", with: @system.resident_tax_level2_multiplication
    fill_in "Resident Tax Level3 Addition", with: @system.resident_tax_level3_addition
    fill_in "Resident Tax Level3 Limit", with: @system.resident_tax_level3_limit
    fill_in "Resident Tax Level3 Multiplication", with: @system.resident_tax_level3_multiplication
    fill_in "Resident Tax Level4 Addition", with: @system.resident_tax_level4_addition
    fill_in "Resident Tax Level4 Limit", with: @system.resident_tax_level4_limit
    fill_in "Resident Tax Level4 Multiplication", with: @system.resident_tax_level4_multiplication
    fill_in "Resident Tax Level5 Addition", with: @system.resident_tax_level5_addition
    fill_in "Resident Tax Level5 Limit", with: @system.resident_tax_level5_limit
    fill_in "Resident Tax Level5 Multiplication", with: @system.resident_tax_level5_multiplication
    click_on "Update System"

    assert_text "System was successfully updated"
    click_on "Back"
  end

  test "destroying a System" do
    visit systems_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "System was successfully destroyed"
  end
end
