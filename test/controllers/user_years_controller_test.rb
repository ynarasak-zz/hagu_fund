require 'test_helper'

class UserYearsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_year = user_years(:one)
  end

  test "should get index" do
    get user_years_url
    assert_response :success
  end

  test "should get new" do
    get new_user_year_url
    assert_response :success
  end

  test "should create user_year" do
    assert_difference('UserYear.count') do
      post user_years_url, params: { user_year: { age: @user_year.age, april_salary: @user_year.april_salary, average_salary: @user_year.average_salary, estimate_age_base_day: @user_year.estimate_age_base_day, june_salary: @user_year.june_salary, max_instalment: @user_year.max_instalment, may_salary: @user_year.may_salary, min_instalment/integer: @user_year.min_instalment/integer, nearest_min_salary: @user_year.nearest_min_salary, sum_salary_10percent: @user_year.sum_salary_10percent, target_year: @user_year.target_year } }
    end

    assert_redirected_to user_year_url(UserYear.last)
  end

  test "should show user_year" do
    get user_year_url(@user_year)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_year_url(@user_year)
    assert_response :success
  end

  test "should update user_year" do
    patch user_year_url(@user_year), params: { user_year: { age: @user_year.age, april_salary: @user_year.april_salary, average_salary: @user_year.average_salary, estimate_age_base_day: @user_year.estimate_age_base_day, june_salary: @user_year.june_salary, max_instalment: @user_year.max_instalment, may_salary: @user_year.may_salary, min_instalment/integer: @user_year.min_instalment/integer, nearest_min_salary: @user_year.nearest_min_salary, sum_salary_10percent: @user_year.sum_salary_10percent, target_year: @user_year.target_year } }
    assert_redirected_to user_year_url(@user_year)
  end

  test "should destroy user_year" do
    assert_difference('UserYear.count', -1) do
      delete user_year_url(@user_year)
    end

    assert_redirected_to user_years_url
  end
end
