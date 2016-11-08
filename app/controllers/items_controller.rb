class ItemsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @item = Item.new(item_params)
    if @item.save && AuctionsController.new.create_auction_for_item(current_user.id, @item.id)
      flash[:success] = 'Item created successfully!'
      redirect_to user_path(id: current_user.id)
    else
      render 'new'
    end
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def index
    if logged_in?
      @items = Item.where("start_datetime >= ?", Date.today)
    else
      redirect_to sessions_new_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :start_datetime, :end_datetime)
  end
end
