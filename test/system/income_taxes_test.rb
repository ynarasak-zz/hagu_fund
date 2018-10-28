require "application_system_test_case"

class IncomeTaxesTest < ApplicationSystemTestCase
  setup do
    @income_tax = income_taxes(:one)
  end

  test "visiting the index" do
    visit income_taxes_url
    assert_selector "h1", text: "Income Taxes"
  end

  test "creating a Income tax" do
    visit income_taxes_url
    click_on "New Income Tax"

    fill_in "Grade", with: @income_tax.grade
    fill_in "Over", with: @income_tax.over
    fill_in "Tax", with: @income_tax.tax
    fill_in "Under", with: @income_tax.under
    click_on "Create Income tax"

    assert_text "Income tax was successfully created"
    click_on "Back"
  end

  test "updating a Income tax" do
    visit income_taxes_url
    click_on "Edit", match: :first

    fill_in "Grade", with: @income_tax.grade
    fill_in "Over", with: @income_tax.over
    fill_in "Tax", with: @income_tax.tax
    fill_in "Under", with: @income_tax.under
    click_on "Update Income tax"

    assert_text "Income tax was successfully updated"
    click_on "Back"
  end

  test "destroying a Income tax" do
    visit income_taxes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Income tax was successfully destroyed"
  end
end
