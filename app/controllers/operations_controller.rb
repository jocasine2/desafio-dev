class OperationsController < ApplicationController
  before_action :set_operation, only: [:show, :update, :destroy]

  # GET /parser
  def parser
    tempfl = params[:file]
    @lines = tempfl.read
    binding.pry
  end

  # GET /operations
  def index
    @operations = Operation.all

    render json: @operations
  end

  # GET /operations/1
  def show
    render json: @operation
  end

  # POST /operations
  def create
    @operation = Operation.new(operation_params)

    if @operation.save
      render json: @operation, status: :created, location: @operation
    else
      render json: @operation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /operations/1
  def update
    if @operation.update(operation_params)
      render json: @operation
    else
      render json: @operation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /operations/1
  def destroy
    @operation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation
      @operation = Operation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def operation_params
      params.require(:operation).permit(:transaction_type_id, :date, :value, :CPF, :card_number, :hour, :owner, :store_name, :file)
    end
end
