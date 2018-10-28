require "application_system_test_case"

class UserYearsTest < ApplicationSystemTestCase
  setup do
    @user_year = user_years(:one)
  end

  test "visiting the index" do
    visit user_years_url
    assert_selector "h1", text: "User Years"
  end

  test "creating a User year" do
    visit user_years_url
    click_on "New User Year"

    fill_in "Age", with: @user_year.age
    fill_in "April Salary", with: @user_year.april_salary
    fill_in "Average Salary", with: @user_year.average_salary
    fill_in "Estimate Age Base Day", with: @user_year.estimate_age_base_day
    fill_in "June Salary", with: @user_year.june_salary
    fill_in "Max Instalment", with: @user_year.max_instalment
    fill_in "May Salary", with: @user_year.may_salary
    fill_in "Min Instalment/Integer", with: @user_year.min_instalment/integer
    fill_in "Nearest Min Salary", with: @user_year.nearest_min_salary
    fill_in "Sum Salary 10percent", with: @user_year.sum_salary_10percent
    fill_in "Target Year", with: @user_year.target_year
    click_on "Create User year"

    assert_text "User year was successfully created"
    click_on "Back"
  end

  test "updating a User year" do
    visit user_years_url
    click_on "Edit", match: :first

    fill_in "Age", with: @user_year.age
    fill_in "April Salary", with: @user_year.april_salary
    fill_in "Average Salary", with: @user_year.average_salary
    fill_in "Estimate Age Base Day", with: @user_year.estimate_age_base_day
    fill_in "June Salary", with: @user_year.june_salary
    fill_in "Max Instalment", with: @user_year.max_instalment
    fill_in "May Salary", with: @user_year.may_salary
    fill_in "Min Instalment/Integer", with: @user_year.min_instalment/integer
    fill_in "Nearest Min Salary", with: @user_year.nearest_min_salary
    fill_in "Sum Salary 10percent", with: @user_year.sum_salary_10percent
    fill_in "Target Year", with: @user_year.target_year
    click_on "Update User year"

    assert_text "User year was successfully updated"
    click_on "Back"
  end

  test "destroying a User year" do
    visit user_years_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User year was successfully destroyed"
  end
end
