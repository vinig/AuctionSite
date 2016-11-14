require 'bcrypt'
class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      IncomeController.new.create_income_account(@user.id) if is_admin? || is_seller?
      flash[:success] = 'Successfully Signed Up!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def find_admin
    User.find_by_role('Administrator')
  end

  private

  def user_params
    params.require(:user).permit(:name, :role, :email, :password, :password_confirmation)
  end

end