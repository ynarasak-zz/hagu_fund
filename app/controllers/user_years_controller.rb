class UserYearsController < ApplicationController
  before_action :set_user_year, only: [:show, :edit, :update, :destroy]

  # GET /user_years
  # GET /user_years.json
  def index
    @user_years = UserYear.all
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

  # POST /user_years
  # POST /user_years.json
  def create
    @user_year = UserYear.new(user_year_params)
    @user_year.users_id = params[:user_year][:users_id]

    respond_to do |format|
      if @user_year.save
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
    respond_to do |format|
      if @user_year.update(user_year_params)
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
      params.require(:user_year).permit(:april_salary, :may_salary, :june_salary, :nearest_min_salary, :estimate_age_base_date, :age, :average_salary, :min_instalment, :sum_salary_10percent, :max_instalment, :target_year)
    end
end
