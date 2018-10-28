require 'test_helper'

class SystemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @system = systems(:one)
  end

  test "should get index" do
    get systems_url
    assert_response :success
  end

  test "should get new" do
    get new_system_url
    assert_response :success
  end

  test "should create system" do
    assert_difference('System.count') do
      post systems_url, params: { system: { kosei_down_annual_income_multiplication: @system.kosei_down_annual_income_multiplication, resident_tax_level1_limit: @system.resident_tax_level1_limit, resident_tax_level2_addition: @system.resident_tax_level2_addition, resident_tax_level2_limit: @system.resident_tax_level2_limit, resident_tax_level2_multiplication: @system.resident_tax_level2_multiplication, resident_tax_level3_addition: @system.resident_tax_level3_addition, resident_tax_level3_limit: @system.resident_tax_level3_limit, resident_tax_level3_multiplication: @system.resident_tax_level3_multiplication, resident_tax_level4_addition: @system.resident_tax_level4_addition, resident_tax_level4_limit: @system.resident_tax_level4_limit, resident_tax_level4_multiplication: @system.resident_tax_level4_multiplication, resident_tax_level5_addition: @system.resident_tax_level5_addition, resident_tax_level5_limit: @system.resident_tax_level5_limit, resident_tax_level5_multiplication: @system.resident_tax_level5_multiplication } }
    end

    assert_redirected_to system_url(System.last)
  end

  test "should show system" do
    get system_url(@system)
    assert_response :success
  end

  test "should get edit" do
    get edit_system_url(@system)
    assert_response :success
  end

  test "should update system" do
    patch system_url(@system), params: { system: { kosei_down_annual_income_multiplication: @system.kosei_down_annual_income_multiplication, resident_tax_level1_limit: @system.resident_tax_level1_limit, resident_tax_level2_addition: @system.resident_tax_level2_addition, resident_tax_level2_limit: @system.resident_tax_level2_limit, resident_tax_level2_multiplication: @system.resident_tax_level2_multiplication, resident_tax_level3_addition: @system.resident_tax_level3_addition, resident_tax_level3_limit: @system.resident_tax_level3_limit, resident_tax_level3_multiplication: @system.resident_tax_level3_multiplication, resident_tax_level4_addition: @system.resident_tax_level4_addition, resident_tax_level4_limit: @system.resident_tax_level4_limit, resident_tax_level4_multiplication: @system.resident_tax_level4_multiplication, resident_tax_level5_addition: @system.resident_tax_level5_addition, resident_tax_level5_limit: @system.resident_tax_level5_limit, resident_tax_level5_multiplication: @system.resident_tax_level5_multiplication } }
    assert_redirected_to system_url(@system)
  end

  test "should destroy system" do
    assert_difference('System.count', -1) do
      delete system_url(@system)
    end

    assert_redirected_to systems_url
  end
end
