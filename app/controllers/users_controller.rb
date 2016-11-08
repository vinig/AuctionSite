require 'bcrypt'
class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
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
    @items = AuctionsController.new.find_user_auction_items(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :role, :email, :password, :password_confirmation)
  end

end