require 'test_helper'

class KoseiGradesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kosei_grade = kosei_grades(:one)
  end

  test "should get index" do
    get kosei_grades_url
    assert_response :success
  end

  test "should get new" do
    get new_kosei_grade_url
    assert_response :success
  end

  test "should create kosei_grade" do
    assert_difference('KoseiGrade.count') do
      post kosei_grades_url, params: { kosei_grade: { base_monthly_salary: @kosei_grade.base_monthly_salary, grade: @kosei_grade.grade, lower_limit: @kosei_grade.lower_limit } }
    end

    assert_redirected_to kosei_grade_url(KoseiGrade.last)
  end

  test "should show kosei_grade" do
    get kosei_grade_url(@kosei_grade)
    assert_response :success
  end

  test "should get edit" do
    get edit_kosei_grade_url(@kosei_grade)
    assert_response :success
  end

  test "should update kosei_grade" do
    patch kosei_grade_url(@kosei_grade), params: { kosei_grade: { base_monthly_salary: @kosei_grade.base_monthly_salary, grade: @kosei_grade.grade, lower_limit: @kosei_grade.lower_limit } }
    assert_redirected_to kosei_grade_url(@kosei_grade)
  end

  test "should destroy kosei_grade" do
    assert_difference('KoseiGrade.count', -1) do
      delete kosei_grade_url(@kosei_grade)
    end

    assert_redirected_to kosei_grades_url
  end
end
