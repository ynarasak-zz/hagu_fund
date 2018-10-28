class UserYearsController < ApplicationController
  before_action :set_user_year, only: [:show, :edit, :update, :destroy]

  # GET /user_years
  # GET /user_years.json
  def index
    @target_year = params["target_year"]
    users_id = params["users_id"]
    
    unless @target_year.blank?
      @user_years = UserYear.where(users_id: users_id, target_year: @target_year)
      @user = User.find(users_id)
      return
    end

    unless users_id.blank?
      @user_years = UserYear.where(users_id: users_id)
      @user = User.find(users_id)
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
    unless @user_year.nearest_min_salary.blank?
      work_cy1 = @c.monthly_base_work_hour * @c.min_instalment
      work_cy2 = work_cy1
      if @user_year.nearest_min_salary > work_cy1
        work_cy2 = @user_year.nearest_min_salary - work_cy1
      end
      @user_year.min_instalment = work_cy2.floor(-3)
    end
    # CZ 平均報酬月額*0.2実行後、100の位から切り捨て
    @user_year.sum_salary_20percent = (@user_year.average_salary * 0.2).floor(-3)

    # BE DA 掛金上限
    if @user_year.min_instalment < @user_year.sum_salary_20percent
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

  def saveEstimate p, type
    @user_year = p
    @user = User.find(@user_year.users_id)
    @c = Company.find(@user.companies_id)

    @estimate = Estimate.new
    @estimate.users_id = @user_year.users_id
    @estimate.target_year = @user_year.target_year
    work_j = @user_year.average_salary
    work_j_minasu1 = @user_year.average_salary - 1
    @kenpo_grade = KenpoGrade.where(over: Float::INFINITY..work_j, under: work_j_minasu1..Float::INFINITY)
    if @kenpo_grade.blank?
      return
    end
    # K 健康保険等級
    @kenpo_grade = @kenpo_grade[0]
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
    

    @estimate.estimate_type = type
    #now
    #plan1
    #plan2
    #plan3
    #maybe2down
    #decision2down
    @estimate.save
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
        saveEstimate @user_year, 'now'
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
    @user_year.destroy
    respond_to do |format|
      format.html { redirect_to user_years_url, notice: 'User year was successfully destroyed.' }
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
