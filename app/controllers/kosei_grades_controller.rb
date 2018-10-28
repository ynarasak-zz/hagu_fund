class KoseiGradesController < ApplicationController
  before_action :set_kosei_grade, only: [:show, :edit, :update, :destroy]

  # GET /kosei_grades
  # GET /kosei_grades.json
  def index
    @kosei_grades = KoseiGrade.all
  end

  # GET /kosei_grades/1
  # GET /kosei_grades/1.json
  def show
  end

  # GET /kosei_grades/new
  def new
    @kosei_grade = KoseiGrade.new
  end

  # GET /kosei_grades/1/edit
  def edit
  end

  # POST /kosei_grades
  # POST /kosei_grades.json
  def create
    @kosei_grade = KoseiGrade.new(kosei_grade_params)

    respond_to do |format|
      if @kosei_grade.save
        format.html { redirect_to @kosei_grade, notice: 'Kosei grade was successfully created.' }
        format.json { render :show, status: :created, location: @kosei_grade }
      else
        format.html { render :new }
        format.json { render json: @kosei_grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kosei_grades/1
  # PATCH/PUT /kosei_grades/1.json
  def update
    respond_to do |format|
      if @kosei_grade.update(kosei_grade_params)
        format.html { redirect_to @kosei_grade, notice: 'Kosei grade was successfully updated.' }
        format.json { render :show, status: :ok, location: @kosei_grade }
      else
        format.html { render :edit }
        format.json { render json: @kosei_grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kosei_grades/1
  # DELETE /kosei_grades/1.json
  def destroy
    @kosei_grade.destroy
    respond_to do |format|
      format.html { redirect_to kosei_grades_url, notice: 'Kosei grade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kosei_grade
      @kosei_grade = KoseiGrade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kosei_grade_params
      params.require(:kosei_grade).permit(:grade, :lower_limit, :base_monthly_salary)
    end
end
