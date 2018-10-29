class UserYearsController < ApplicationController
  before_action :set_user_year, only: [:show, :edit, :update, :destroy]
  @@now_tax = 0

  # GET /user_years
  # GET /user_years.json
  def index
    @target_year = params["target_year"]
    users_id = params["users_id"]
    
    unless @target_year.blank?
      @user_years = UserYear.where(users_id: users_id, target_year: @target_year)
      @user = User.find(users_id)
      @companies_id = @user.companies_id
      return
    end

    unless users_id.blank?
      @user_years = UserYear.where(users_id: users_id)
      @user = User.find(users_id)
      @companies_id = @user.companies_id
    else
      @user_years = UserYear.all
    end

  end

  # GET /user_years/1
  # GET /user_years/1.json
  def show
  end

  # GET /user_years/new
  def new
    @user_year = UserYear.new
  end

  # GET /user_years/1/edit
  def edit
  end

  def setData p
    @user_year = p
    @user = User.find(@user_year.users_id)
    @c = Company.find(@user.companies_id)
    @user_year.estimate_age_base_date = Date.today
    date_format = "%Y%m%d"
    @user_year.age = (@user_year.estimate_age_base_date.strftime(date_format).to_i - @user.birthday.strftime(date_format).to_i) / 10000

    # J12 平均報酬月額
    count = 0
    if @user_year.april_salary > 0
      count += 1
    end
    if @user_year.may_salary > 0
      count += 1
    end
    if @user_year.june_salary > 0
      count += 1
    end
    @user_year.average_salary = (BigDecimal(@user_year.april_salary + @user_year.may_salary + @user_year.june_salary) / count).round
    
    # CY 最賃掛金
    @user_year.min_instalment = 0
    unless @user_year.nearest_min_salary.blank? && @user_year.nearest_min_salary > 0
      work_cy1 = @c.monthly_base_work_hour * @c.min_instalment
      work_cy2 = work_cy1
      if @user_year.nearest_min_salary > work_cy1
        work_cy2 = @user_year.nearest_min_salary - work_cy1
      end
      @user_year.min_instalment = work_cy2.floor(-3)
    end
    # CZ 平均報酬月額*0.2実行後、100の位から切り捨て
    @user_year.sum_salary_20percent = (@user_year.average_salary * 0.2).floor(-3)

    # BE DA 掛金上限 100の位で切り捨て
    if @user_year.min_instalment < @user_year.sum_salary_20percent && @user_year.min_instalment > 0
      @user_year.max_instalment = @user_year.min_instalment.floor(-3)
    else
      @user_year.max_instalment = @user_year.sum_salary_20percent.floor(-3)
    end
    
    @estimate = Estimate.where(users_id: @user_year.users_id, target_year: @user_year.target_year)

    unless @estimate.blank?
      @estimate.destroy_all
    end

    @user_year
  end

  # 指定された金額から健康保険等級マスタを取得する
  def getKenpoGrade salary
    work_j = salary
    work_j_minasu1 = salary - 1

    # 等級マスタ取得
    KenpoGrade.where(over: Float::INFINITY..work_j, under: work_j_minasu1..Float::INFINITY)[0]
  end

  # 指定された金額から厚生年金マスタを取得する
  def getKoseiGrade salary
    KoseiGrade.where(lower_limit: Float::INFINITY..salary).order("grade desc")[0]
  end

  # シミュレーションし保存する
  # now/plan1/plan2/plan3/maybe2down/decision2down
  def saveEstimate p, type, now_grade, now_average_salary, lower_base_grade
    @user_year = p
    @sys = System.all[0]
    @user = User.find(@user_year.users_id)
    @c = Company.find(@user.companies_id)

    @estimate = Estimate.new
    @estimate.users_id = @user_year.users_id
    @estimate.target_year = @user_year.target_year
    @estimate.new_salary = 0
    
    # PLAN1系 W 報酬下限 & X 必要な掛金 & Y 新報酬月額
    if type.eql?('plan1') || type.eql?('maybe2down')
      @estimate.lower_limit_fee = lower_base_grade.over
      # X 必要な掛金
      if now_grade.grade <= 1
        @estimate.instalment = 0
      elsif now_grade.grade >= 2
        @estimate.instalment = (now_average_salary - @estimate.lower_limit_fee + 100).ceil(-3)
      end

      if @estimate.instalment < 1000
        @estimate.instalment = 1000
      end

      # Y 新報酬月額
      if @estimate.instalment >= 1000 && now_average_salary > @estimate.instalment
        @estimate.new_salary = now_average_salary - @estimate.instalment
      end
    end

    # PLAN3 Y 新報酬月額
    if type.eql?('plan3')
      if now_average_salary > @user_year.max_instalment
        @estimate.new_salary = now_average_salary - @user_year.max_instalment
      end
    end

    # PLAN2系 X 必要な掛金 & Y 新報酬月額
    if type.eql?('plan2')
      # decision1
      @estimate.instalment = now_grade.decision_1_down
      if now_average_salary > @user_year.max_instalment
        @estimate.new_salary = now_average_salary - @estimate.instalment
      end
    elsif type.eql?('decision2down')
      # decision2
      @estimate.instalment = now_grade.decision_2_down
      if now_average_salary > @user_year.max_instalment
        @estimate.new_salary = now_average_salary - @estimate.instalment
      end
    end
    @estimate.estimate_type = type

    base_salary = @estimate.new_salary

    if type.eql?('now')
      base_salary = now_average_salary
    end

    work_j = base_salary

    # 等級マスタ取得
    @kenpo_grade = getKenpoGrade base_salary
    if @kenpo_grade.blank?
      return
    end
    # K 健康保険等級
    @estimate.kenpo_grade = @kenpo_grade.grade

    # L 健康保険料
    if @user_year.age < 75
      @estimate.kenpo_price = ((@kenpo_grade.base_monthly_salary * @c.kenpo_charge_employee_rate)).round
    else
      @estimate.kenpo_price = 0
    end

    # M 介護保険料
    if @user_year.age >= 40 && @user_year.age < 65
      @estimate.kaigo_price = ((@kenpo_grade.base_monthly_salary * @c.kenpo_kaigo_rate)/2).round
    else
      @estimate.kaigo_price = 0
    end
   
    # N 厚生年金等級
    # 厚生年金等級マスタ取得
    @kosei_grade = getKoseiGrade work_j
    @estimate.kosei_grade = @kosei_grade.grade

    # O 厚生年金保険料
    if @user_year.age < 70
      @estimate.kosei_price = ((@kosei_grade.base_monthly_salary * @c.kosei_rate)/2).round
    else
      @estimate.kosei_price = 0
    end

    
    # P 厚生年金基金保険料
    if @user_year.age < 70
      @estimate.kikin_price = (@kosei_grade.base_monthly_salary * @c.kikin_charge_employee_rate).round
    else
      @estimate.kikin_price = 0
    end

    # Q 雇用保険料
    @estimate.koyou_price = (work_j * @c.koyou_rate).round

    # R 社会保険料控除
    # 健康保険料+介護保険料+厚生年金保険料+厚生年金基金保険料+雇用保険料
    @estimate.syaho_koujyo = @estimate.kenpo_price + @estimate.kaigo_price + @estimate.kosei_price + @estimate.kikin_price + @estimate.koyou_price


    # S 課税対象所得
    tax_target_price = work_j - @estimate.syaho_koujyo
    if tax_target_price > 0
      @estimate.tax_target_price = tax_target_price
    else
      @estimate.tax_target_price = 0
      tax_target_price = 0
    end

    # T 所得税
    @income_tax = IncomeTax.where(over: Float::INFINITY..tax_target_price, under: tax_target_price-1..Float::INFINITY)[0]

    # level5
    if tax_target_price >= @sys.resident_tax_level5_limit
      @estimate.income_tax = ((BigDecimal((tax_target_price - @sys.resident_tax_level4_limit) * @sys.resident_tax_level5_multiplication)) + resident_tax_level5_addition).floor
    # level4
    elsif tax_target_price >= @sys.resident_tax_level3_limit && tax_target_price < @sys.resident_tax_level4_limit
      @estimate.income_tax = ((BigDecimal((tax_target_price - @sys.resident_tax_level3_limit) * @sys.resident_tax_level4_multiplication)) + resident_tax_level4_addition).floor
    # level3
    elsif tax_target_price >= @sys.resident_tax_level2_limit && tax_target_price < @sys.resident_tax_level3_limit
      @estimate.income_tax = ((BigDecimal((tax_target_price - @sys.resident_tax_level2_limit) * @sys.resident_tax_level3_multiplication)) + resident_tax_level3_addition).floor
    # level2
    elsif tax_target_price > @sys.resident_tax_level1_limit && tax_target_price < @sys.resident_tax_level2_limit
      @estimate.income_tax = ((BigDecimal((tax_target_price - @sys.resident_tax_level1_limit) * @sys.resident_tax_level2_multiplication)) + resident_tax_level2_addition).floor
    # level1
    elsif tax_target_price <= @sys.resident_tax_level1_limit
      @estimate.income_tax = @income_tax.tax
    end

    # U 住民税
    @estimate.resident_tax = (tax_target_price * 0.1).floor

    # V 税金合計
    @estimate.sum_tax = @estimate.income_tax + @estimate.resident_tax

    ## nowはここで終了
    if type.eql?('now')
      @@now_tax = (@estimate.syaho_koujyo + @estimate.sum_tax)
    else
      # 現在の値を取得
      # AL 節税効果
      @estimate.tax_economy_result = (@@now_tax - (@estimate.syaho_koujyo + @estimate.sum_tax))*12

      # AM 厚生年金受給節減額(年)
      # 現在のKoseGradeを取得し、そこから標準報酬月額を取得する
      nowKosei = getKoseiGrade now_average_salary
    
      @estimate.kosei_down_annual_income = ((nowKosei.base_monthly_salary - @kosei_grade.base_monthly_salary)*@sys.kosei_down_annual_income_multiplication/1000*12).round
    end
    @estimate.save!
  end

  # POST /user_years
  # POST /user_years.json
  def create
    @user_year = UserYear.new(user_year_params)
    @user_year.users_id = params[:user_year][:users_id]
    @user_year = setData @user_year

    #@user = User.find(@user_year.users_id)
    #@c = Company.find(@user.companies_id)
    #@user_year.estimate_age_base_date = Date.today
    #date_format = "%Y%m%d"
    #@user_year.age = (@user_year.estimate_age_base_date.strftime(date_format).to_i - @user.birthday.strftime(date_format).to_i) / 10000

    # J12 平均報酬月額
    #@user_year.average_salary = (BigDecimal(@user_year.april_salary + @user_year.may_salary + @user_year.june_salary) / 3).round

    # CY 最賃掛金
    #@user_year.min_instalment = 0
    #unless @user_year.nearest_min_salary.blank?
    #  work_cy1 = @c.monthly_base_work_hour * @c.min_instalment
    #  work_cy2 = work_cy1
    #  if @user_year.nearest_min_salary > work_cy1
    #    work_cy2 = @user_year.nearest_min_salary - work_cy1
    #  end
    #  @user_year.min_instalment = work_cy2.floor(-3)
    #end
    # CZ 平均報酬月額*0.2実行後、100の位から切り捨て
    #@user_year.sum_salary_20percent = (@user_year.average_salary * 0.2).floor(-3)

    # BE DA 掛金上限
    #if @user_year.min_instalment < @user_year.sum_salary_20percent
    #  @user_year.max_instalment = @user_year.min_instalment.floor(-3)
    #else
    #  @user_year.max_instalment = @user_year.sum_salary_20percent.floor(-3)
    #end

    respond_to do |format|
      if @user_year.save
        now_grade = getKenpoGrade @user_year.average_salary
        saveEstimate @user_year, 'now', now_grade, @user_year.average_salary, nil
        saveEstimate @user_year, 'plan1', now_grade, @user_year.average_salary, now_grade
        plan1_grade = Estimate.where(users_id: @user_year.users_id, target_year: @user_year.target_year, estimate_type: 'plan1')[0].kenpo_grade
        lower_base_grade = KenpoGrade.where(grade: plan1_grade)[0]
        saveEstimate @user_year, 'maybe2down', now_grade, @user_year.average_salary, lower_base_grade
        saveEstimate @user_year, 'plan3', now_grade, @user_year.average_salary, nil
        saveEstimate @user_year, 'plan2', now_grade, @user_year.average_salary, nil
        saveEstimate @user_year, 'decision2down', now_grade, @user_year.average_salary, nil

        format.html { redirect_to @user_year, notice: 'User year was successfully created.' }
        format.json { render :show, status: :created, location: @user_year }
      else
        format.html { render :new }
        format.json { render json: @user_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_years/1
  # PATCH/PUT /user_years/1.json
  def update
    @user_year = setData @user_year
    respond_to do |format|
      if @user_year.update(user_year_params)
        saveEstimate @user_year, 'now'
        format.html { redirect_to @user_year, notice: 'User year was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_year }
      else
        format.html { render :edit }
        format.json { render json: @user_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_years/1
  # DELETE /user_years/1.json
  def destroy
    @target_year = @user_year.target_year
    @users_id = @user_year.users_id
    @user_year.destroy
    respond_to do |format|
      format.html { redirect_to user_years_url(target_year: @target_year, users_id: @users_id), notice: 'User year was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_year
      @user_year = UserYear.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_year_params
      params.require(:user_year).permit(:april_salary, :may_salary, :june_salary, :nearest_min_salary, :estimate_age_base_date, :age, :average_salary, :min_instalment, :sum_salary_20percent, :max_instalment, :target_year)
    end
end
