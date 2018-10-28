require 'test_helper'

class IncomeTaxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @income_tax = income_taxes(:one)
  end

  test "should get index" do
    get income_taxes_url
    assert_response :success
  end

  test "should get new" do
    get new_income_tax_url
    assert_response :success
  end

  test "should create income_tax" do
    assert_difference('IncomeTax.count') do
      post income_taxes_url, params: { income_tax: { grade: @income_tax.grade, over: @income_tax.over, tax: @income_tax.tax, under: @income_tax.under } }
    end

    assert_redirected_to income_tax_url(IncomeTax.last)
  end

  test "should show income_tax" do
    get income_tax_url(@income_tax)
    assert_response :success
  end

  test "should get edit" do
    get edit_income_tax_url(@income_tax)
    assert_response :success
  end

  test "should update income_tax" do
    patch income_tax_url(@income_tax), params: { income_tax: { grade: @income_tax.grade, over: @income_tax.over, tax: @income_tax.tax, under: @income_tax.under } }
    assert_redirected_to income_tax_url(@income_tax)
  end

  test "should destroy income_tax" do
    assert_difference('IncomeTax.count', -1) do
      delete income_tax_url(@income_tax)
    end

    assert_redirected_to income_taxes_url
  end
end
