class ItemsController < ApplicationController
  include ItemsHelper
  skip_before_filter :verify_authenticity_token

  def create
    @item = Item.new(item_params)
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
    if !(@is_admin || @is_seller)
      @bid = BidsController.new.user_bid_for_item(current_user.id, @item.id)
    end
  end

  def index
    if logged_in?
      all_items = Item.where("end_datetime >= ?", Time.now)
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
    redirect_to all_items_path
  end

  def update_item_auction
    item = Item.find_by_id(params[:id])
    update_item_auction_local(item)
    respond_to do |format|
      format.json { render nothing: true, status: 200 }
    end
  end

  def update_item_auction_local(item)
    mark_sold(item)
    auction = AuctionsController.new.set_auction_invalid(item.id) # for seller
    bid = BidsController.new.find_highest_bids_for_item(item) # for bidder

    if !bid.empty?
      admin = UsersController.new.find_admin
      amount = bid[0].price
      incomeController = IncomeController.new
      incomeController.update_income(admin.id, amount*0.05)
      incomeController.update_income(auction.user_id, amount*0.95)
    end
  end

  def item_update_winner(item, user_id)
    if item.winner.nil?
      item.update_attributes(winner: user_id)
      item.save(validate: false)
    end
  end

  def get_items(item_ids)
    item_ids.collect { |i| Item.find_by_id(i) }
  end

  private

  def mark_sold(item)
    item.update_attributes(sold: true)
    item.save(validate: false)
  end

  def item_params
    params.require(:item).permit(:name, :price, :start_datetime, :end_datetime)
  end
end