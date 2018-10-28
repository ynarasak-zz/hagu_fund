class KenpoGradesController < ApplicationController
  before_action :set_kenpo_grade, only: [:show, :edit, :update, :destroy]

  # GET /kenpo_grades
  # GET /kenpo_grades.json
  def index
    @kenpo_grades = KenpoGrade.all
  end

  # GET /kenpo_grades/1
  # GET /kenpo_grades/1.json
  def show
  end

  # GET /kenpo_grades/new
  def new
    @kenpo_grade = KenpoGrade.new
  end

  # GET /kenpo_grades/1/edit
  def edit
  end

  # POST /kenpo_grades
  # POST /kenpo_grades.json
  def create
    @kenpo_grade = KenpoGrade.new(kenpo_grade_params)

    respond_to do |format|
      if @kenpo_grade.save
        format.html { redirect_to @kenpo_grade, notice: 'Kenpo grade was successfully created.' }
        format.json { render :show, status: :created, location: @kenpo_grade }
      else
        format.html { render :new }
        format.json { render json: @kenpo_grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kenpo_grades/1
  # PATCH/PUT /kenpo_grades/1.json
  def update
    respond_to do |format|
      if @kenpo_grade.update(kenpo_grade_params)
        format.html { redirect_to @kenpo_grade, notice: 'Kenpo grade was successfully updated.' }
        format.json { render :show, status: :ok, location: @kenpo_grade }
      else
        format.html { render :edit }
        format.json { render json: @kenpo_grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kenpo_grades/1
  # DELETE /kenpo_grades/1.json
  def destroy
    @kenpo_grade.destroy
    respond_to do |format|
      format.html { redirect_to kenpo_grades_url, notice: 'Kenpo grade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kenpo_grade
      @kenpo_grade = KenpoGrade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kenpo_grade_params
      params.require(:kenpo_grade).permit(:grade, :over, :under, :base_monthly_salary, :decision_1_down, :decision_2_down)
    end
end
