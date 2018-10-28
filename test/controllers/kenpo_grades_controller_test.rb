require 'test_helper'

class KenpoGradesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kenpo_grade = kenpo_grades(:one)
  end

  test "should get index" do
    get kenpo_grades_url
    assert_response :success
  end

  test "should get new" do
    get new_kenpo_grade_url
    assert_response :success
  end

  test "should create kenpo_grade" do
    assert_difference('KenpoGrade.count') do
      post kenpo_grades_url, params: { kenpo_grade: { base_monthly_salary: @kenpo_grade.base_monthly_salary, decision_1_down: @kenpo_grade.decision_1_down, decision_2_down: @kenpo_grade.decision_2_down, grade: @kenpo_grade.grade, over: @kenpo_grade.over, under: @kenpo_grade.under } }
    end

    assert_redirected_to kenpo_grade_url(KenpoGrade.last)
  end

  test "should show kenpo_grade" do
    get kenpo_grade_url(@kenpo_grade)
    assert_response :success
  end

  test "should get edit" do
    get edit_kenpo_grade_url(@kenpo_grade)
    assert_response :success
  end

  test "should update kenpo_grade" do
    patch kenpo_grade_url(@kenpo_grade), params: { kenpo_grade: { base_monthly_salary: @kenpo_grade.base_monthly_salary, decision_1_down: @kenpo_grade.decision_1_down, decision_2_down: @kenpo_grade.decision_2_down, grade: @kenpo_grade.grade, over: @kenpo_grade.over, under: @kenpo_grade.under } }
    assert_redirected_to kenpo_grade_url(@kenpo_grade)
  end

  test "should destroy kenpo_grade" do
    assert_difference('KenpoGrade.count', -1) do
      delete kenpo_grade_url(@kenpo_grade)
    end

    assert_redirected_to kenpo_grades_url
  end
end
