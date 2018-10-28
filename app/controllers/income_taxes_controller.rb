class IncomeTaxesController < ApplicationController
  before_action :set_income_tax, only: [:show, :edit, :update, :destroy]

  # GET /income_taxes
  # GET /income_taxes.json
  def index
    @income_taxes = IncomeTax.all
  end

  # GET /income_taxes/1
  # GET /income_taxes/1.json
  def show
  end

  # GET /income_taxes/new
  def new
    @income_tax = IncomeTax.new
  end

  # GET /income_taxes/1/edit
  def edit
  end

  # POST /income_taxes
  # POST /income_taxes.json
  def create
    @income_tax = IncomeTax.new(income_tax_params)

    respond_to do |format|
      if @income_tax.save
        format.html { redirect_to @income_tax, notice: 'Income tax was successfully created.' }
        format.json { render :show, status: :created, location: @income_tax }
      else
        format.html { render :new }
        format.json { render json: @income_tax.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /income_taxes/1
  # PATCH/PUT /income_taxes/1.json
  def update
    respond_to do |format|
      if @income_tax.update(income_tax_params)
        format.html { redirect_to @income_tax, notice: 'Income tax was successfully updated.' }
        format.json { render :show, status: :ok, location: @income_tax }
      else
        format.html { render :edit }
        format.json { render json: @income_tax.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /income_taxes/1
  # DELETE /income_taxes/1.json
  def destroy
    @income_tax.destroy
    respond_to do |format|
      format.html { redirect_to income_taxes_url, notice: 'Income tax was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_income_tax
      @income_tax = IncomeTax.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def income_tax_params
      params.require(:income_tax).permit(:grade, :over, :under, :tax)
    end
end
