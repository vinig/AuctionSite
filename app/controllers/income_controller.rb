class IncomeController < ApplicationController
  def show
    @income = Income.find_by_user_id(params[:id])
  end

  def create_income_account(user_id)
    Income.create!(user_id: user_id, income: 0)
  end
end
