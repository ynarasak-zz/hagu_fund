require "application_system_test_case"

class KoseiGradesTest < ApplicationSystemTestCase
  setup do
    @kosei_grade = kosei_grades(:one)
  end

  test "visiting the index" do
    visit kosei_grades_url
    assert_selector "h1", text: "Kosei Grades"
  end

  test "creating a Kosei grade" do
    visit kosei_grades_url
    click_on "New Kosei Grade"

    fill_in "Base Monthly Salary", with: @kosei_grade.base_monthly_salary
    fill_in "Grade", with: @kosei_grade.grade
    fill_in "Lower Limit", with: @kosei_grade.lower_limit
    click_on "Create Kosei grade"

    assert_text "Kosei grade was successfully created"
    click_on "Back"
  end

  test "updating a Kosei grade" do
    visit kosei_grades_url
    click_on "Edit", match: :first

    fill_in "Base Monthly Salary", with: @kosei_grade.base_monthly_salary
    fill_in "Grade", with: @kosei_grade.grade
    fill_in "Lower Limit", with: @kosei_grade.lower_limit
    click_on "Update Kosei grade"

    assert_text "Kosei grade was successfully updated"
    click_on "Back"
  end

  test "destroying a Kosei grade" do
    visit kosei_grades_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Kosei grade was successfully destroyed"
  end
end
