class PrintController < ApplicationController
  def index
    users_id = params["users_id"]
    target_year = params["target_year"]
    if users_id.blank?
      return
    end
    @user = User.find(users_id)
    @c = Company.find(@user.companies_id)
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

    if @plan1_est.instalment > @user_year.max_instalment
      @plan_label = "プラン③の積み立てイメージ"
      @f4_instalment = @user_year.max_instalment
      @kosei_down_annual_income  = @plan3_est.kosei_down_annual_income
    else
      @plan_label = "プラン①の積み立てイメージ"
      @f4_instalment = @plan1_est.instalment
      @kosei_down_annual_income  = @plan1_est.kosei_down_annual_income
    end

    if @user_year.age < 40
      @graph1_label = "3年間積⽴"
      @graph1_ganri = ganriSum 3, @f4_instalment, @c.interest_rate
      @graph1_tumi = 3*@f4_instalment*12

      @graph2_label = "9年間積⽴"
      @graph2_ganri = ganriSum 9, @f4_instalment, @c.interest_rate
      @graph2_tumi = 9*@f4_instalment*12

      @graph3_label = "15年間積⽴"
      @graph3_ganri = ganriSum 15, @f4_instalment, @c.interest_rate
      @graph3_tumi = 15*@f4_instalment*12
    elsif @user_year.age >= 40
      @graph1_label = "6年間積⽴"
      @graph1_ganri = ganriSum 6, @f4_instalment, @c.interest_rate
      @graph1_tumi = 6*@f4_instalment*12

      @graph2_label = "12年間積⽴"
      @graph2_ganri = ganriSum 12, @f4_instalment, @c.interest_rate
      @graph2_tumi = 12*@f4_instalment*12

      @graph3_label = "６５歳までの年数"
      @graph3_ganri = ganriSum (65-@user_year.age), @f4_instalment, @c.interest_rate
      @graph3_tumi = (65-@user_year.age)*@f4_instalment*12
    end

    #利息
    @graph1_risoku = @graph1_ganri - @graph1_tumi
    @graph2_risoku = @graph2_ganri - @graph2_tumi
    @graph3_risoku = @graph3_ganri - @graph3_tumi

    render :layout => nil
  end

  def ganriSum year, f4, rate
    base_ganri = 0;
    work = 0;
    risoku = 0;
    for i in 1..year
      if i.eql?(1)
        base_ganri = f4*12
        work = base_ganri
      else
        work = base_ganri + risoku
      end

      risoku = (work * (1 + rate)).round
    end
    risoku
  end
end
