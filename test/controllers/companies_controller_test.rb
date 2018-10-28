require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company = companies(:one)
  end

  test "should get index" do
    get companies_url
    assert_response :success
  end

  test "should get new" do
    get new_company_url
    assert_response :success
  end

  test "should create company" do
    assert_difference('Company.count') do
      post companies_url, params: { company: { interest_rate: @company.interest_rate, kenpo_charge_employee_rate: @company.kenpo_charge_employee_rate, kenpo_kaigo_rate: @company.kenpo_kaigo_rate, kikin_charge_employee_rate: @company.kikin_charge_employee_rate, kosei_rate: @company.kosei_rate, koyou_rate: @company.koyou_rate, min_instalment: @company.min_instalment, monthly_base_work_hour: @company.monthly_base_work_hour, name: @company.name } }
    end

    assert_redirected_to company_url(Company.last)
  end

  test "should show company" do
    get company_url(@company)
    assert_response :success
  end

  test "should get edit" do
    get edit_company_url(@company)
    assert_response :success
  end

  test "should update company" do
    patch company_url(@company), params: { company: { interest_rate: @company.interest_rate, kenpo_charge_employee_rate: @company.kenpo_charge_employee_rate, kenpo_kaigo_rate: @company.kenpo_kaigo_rate, kikin_charge_employee_rate: @company.kikin_charge_employee_rate, kosei_rate: @company.kosei_rate, koyou_rate: @company.koyou_rate, min_instalment: @company.min_instalment, monthly_base_work_hour: @company.monthly_base_work_hour, name: @company.name } }
    assert_redirected_to company_url(@company)
  end

  test "should destroy company" do
    assert_difference('Company.count', -1) do
      delete company_url(@company)
    end

    assert_redirected_to companies_url
  end
end
