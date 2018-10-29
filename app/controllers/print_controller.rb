class PrintController < ApplicationController
  def index
    users_id = params["users_id"]
    target_year = params["target_year"]
    if users_id.blank?
      return
    end
    @user = User.find(users_id)
    @user_year = UserYear.where(users_id: users_id, target_year: target_year)[0]
    @now_est = Estimate.where(users_id: users_id, target_year: target_year, estimate_type: 'now')[0]
    @now_syaho_12 = @now_est.syaho_koujyo*12
    @now_sum_tax_12 = @now_est.sum_tax*12

    @plan1_est = Estimate.where(users_id: users_id, target_year: target_year, estimate_type: 'plan1')[0]
    @plan1_syaho_12 = @plan1_est.syaho_koujyo*12
    @plan1_sum_tax_12 = @plan1_est.sum_tax*12
    @plan1_tax_economy_result = @plan1_est.tax_economy_result
    @plan1_tumi_12 = @plan1_est.instalment*12

    @plan2_est = Estimate.where(users_id: users_id, target_year: target_year, estimate_type: 'plan2')[0]
    @plan2_syaho_12 = @plan2_est.syaho_koujyo*12
    @plan2_sum_tax_12 = @plan2_est.sum_tax*12
    @plan2_tax_economy_result = @plan2_est.tax_economy_result
    @plan2_tumi_12 = @plan2_est.instalment*12

    @plan3_est = Estimate.where(users_id: users_id, target_year: target_year, estimate_type: 'plan3')[0]
    @plan3_syaho_12 = @plan3_est.syaho_koujyo*12
    @plan3_sum_tax_12 = @plan3_est.sum_tax*12
    @plan3_tax_economy_result = @plan3_est.tax_economy_result
    @plan3_tumi_12 = @user_year.max_instalment*12
    render :layout => nil
  end
end
