class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show update destroy ]
  before_action :authenticate_user!

  # GET /expenses
  def index
    expenses = current_user.expenses.includes(:category).order(created_at: :desc)
    @total_expenses = current_user.expenses.total_expenses

    @all_expenses = []
    expenses.each do |expense|
      @all_expenses << expense.json_format
    end

    render json: {
      expenses: @all_expenses,
      total_expenses: @total_expenses
    }
  end

  # GET /expenses/1
  def show
    render json: @expense
  end

  def latest
    latest_expense = Expense.last
    render json: latest_expense.json_format
  end

  # POST /expenses
  def create
    @expense = Expense.new(expense_params)
    @expense.user = current_user

    if @expense.save
      render json: {
        message: 'Transaction was successfully recorded'
      }, status: :created
    else
      render json: {
        message: 'Transaction was not successfully recorded',
        errors: @expense.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /expenses/1
  def update
    if @expense.update(expense_params)
      render json: @expense
    else
      render json: @expense.errors, status: :unprocessable_entity
    end
  end

  # DELETE /expenses/1
  def destroy
    @expense.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expense_params
      params.require(:expense).permit(:name, :amount, :category_id)
    end
end
