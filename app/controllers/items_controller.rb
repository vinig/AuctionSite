class ItemsController < ApplicationController
  include ItemsHelper
  skip_before_filter :verify_authenticity_token

  def create
    @item = Item.new(item_params)
    require 'pry'; binding.pry
    if (val = @item.save) && AuctionsController.new.create_auction_for_item(current_user.id, @item.id, val)
      flash[:success] = 'Item created successfully!'
      redirect_to user_path(id: current_user.id)
    else
      flash[:danger] = 'Incorrect information.'
      render 'new'
    end
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
    @is_admin = is_admin?
    @is_seller = is_seller?
  end

  def index
    if logged_in?
      all_items = Item.where("start_datetime >= ?", Date.today)
      @items = all_items.select {|i| auction_eligible?(i.id)}
    else
      redirect_to sessions_new_path
    end
  end

  def all_items
    if is_admin?
      @is_admin = true
      @items = Item.all
    elsif is_seller?
      @is_seller = true
      @items = AuctionsController.new.find_user_auction_items(current_user.id, true)
    end
    render 'index'
    # for bidder: @items = AuctionsController.new.find_user_auction_items(@user.id, false)
  end

  def destroy
    auction = Auction.find_by_item_id(params[:id])
    Auction.destroy(auction.id)
    Item.destroy(params[:id])
    redirect_to current_user
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :start_datetime, :end_datetime)
  end
end