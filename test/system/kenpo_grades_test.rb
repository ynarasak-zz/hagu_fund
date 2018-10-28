require "application_system_test_case"

class KenpoGradesTest < ApplicationSystemTestCase
  setup do
    @kenpo_grade = kenpo_grades(:one)
  end

  test "visiting the index" do
    visit kenpo_grades_url
    assert_selector "h1", text: "Kenpo Grades"
  end

  test "creating a Kenpo grade" do
    visit kenpo_grades_url
    click_on "New Kenpo Grade"

    fill_in "Base Monthly Salary", with: @kenpo_grade.base_monthly_salary
    fill_in "Decision 1 Down", with: @kenpo_grade.decision_1_down
    fill_in "Decision 2 Down", with: @kenpo_grade.decision_2_down
    fill_in "Grade", with: @kenpo_grade.grade
    fill_in "Over", with: @kenpo_grade.over
    fill_in "Under", with: @kenpo_grade.under
    click_on "Create Kenpo grade"

    assert_text "Kenpo grade was successfully created"
    click_on "Back"
  end

  test "updating a Kenpo grade" do
    visit kenpo_grades_url
    click_on "Edit", match: :first

    fill_in "Base Monthly Salary", with: @kenpo_grade.base_monthly_salary
    fill_in "Decision 1 Down", with: @kenpo_grade.decision_1_down
    fill_in "Decision 2 Down", with: @kenpo_grade.decision_2_down
    fill_in "Grade", with: @kenpo_grade.grade
    fill_in "Over", with: @kenpo_grade.over
    fill_in "Under", with: @kenpo_grade.under
    click_on "Update Kenpo grade"

    assert_text "Kenpo grade was successfully updated"
    click_on "Back"
  end

  test "destroying a Kenpo grade" do
    visit kenpo_grades_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Kenpo grade was successfully destroyed"
  end
end
