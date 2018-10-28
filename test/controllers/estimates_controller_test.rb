require 'test_helper'

class EstimatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @estimate = estimates(:one)
  end

  test "should get index" do
    get estimates_url
    assert_response :success
  end

  test "should get new" do
    get new_estimate_url
    assert_response :success
  end

  test "should create estimate" do
    assert_difference('Estimate.count') do
      post estimates_url, params: { estimate: { income_tax: @estimate.income_tax, instalment: @estimate.instalment, kaigo_price: @estimate.kaigo_price, kenpo_grade: @estimate.kenpo_grade, kenpo_price: @estimate.kenpo_price, kikin_price: @estimate.kikin_price, kosei_down_annual_income: @estimate.kosei_down_annual_income, kosei_grade: @estimate.kosei_grade, kosei_price: @estimate.kosei_price, koyou_price: @estimate.koyou_price, lower_limit_fee: @estimate.lower_limit_fee, new_salary: @estimate.new_salary, resident_tax: @estimate.resident_tax, sum_tax: @estimate.sum_tax, syaho_koujyo: @estimate.syaho_koujyo, target_year: @estimate.target_year, tax_economy_result: @estimate.tax_economy_result, tax_target_price: @estimate.tax_target_price, type: @estimate.type } }
    end

    assert_redirected_to estimate_url(Estimate.last)
  end

  test "should show estimate" do
    get estimate_url(@estimate)
    assert_response :success
  end

  test "should get edit" do
    get edit_estimate_url(@estimate)
    assert_response :success
  end

  test "should update estimate" do
    patch estimate_url(@estimate), params: { estimate: { income_tax: @estimate.income_tax, instalment: @estimate.instalment, kaigo_price: @estimate.kaigo_price, kenpo_grade: @estimate.kenpo_grade, kenpo_price: @estimate.kenpo_price, kikin_price: @estimate.kikin_price, kosei_down_annual_income: @estimate.kosei_down_annual_income, kosei_grade: @estimate.kosei_grade, kosei_price: @estimate.kosei_price, koyou_price: @estimate.koyou_price, lower_limit_fee: @estimate.lower_limit_fee, new_salary: @estimate.new_salary, resident_tax: @estimate.resident_tax, sum_tax: @estimate.sum_tax, syaho_koujyo: @estimate.syaho_koujyo, target_year: @estimate.target_year, tax_economy_result: @estimate.tax_economy_result, tax_target_price: @estimate.tax_target_price, type: @estimate.type } }
    assert_redirected_to estimate_url(@estimate)
  end

  test "should destroy estimate" do
    assert_difference('Estimate.count', -1) do
      delete estimate_url(@estimate)
    end

    assert_redirected_to estimates_url
  end
end
