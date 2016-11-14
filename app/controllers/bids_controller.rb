class BidsController < ApplicationController
  def create
    bid = Bid.new(user_id: current_user.id, item_id: params[:bid][:item_id], price: params[:bid][:price])
    if bid.save
      flash[:success] = 'Successfully placed the bid!'
      redirect_to items_path
    end
  end

  def update
    bid = Bid.find_by_id(params[:id])
    bid.update_attributes(price: params[:bid][:price])
    if bid.save
      flash[:success] = 'Successfully placed the bid!'
      redirect_to items_path
    end
  end

  def user_bid_for_item(user_id, item_id)
    Bid.find_by(user_id: user_id, item_id: item_id)
  end

  def find_highest_bids_for_item(item)
    bids =  Bid.where(item_id: item.id)
    highest_bid = bids.order(price: :desc).limit(1)
    if !highest_bid.empty?
      ItemsController.new.item_update_winner(item, highest_bid[0].user_id)
    end
    highest_bid
  end

  def show
    user_id = params[:id]
    all_bids = get_bids_for_user(user_id)
    all_items = ItemsController.new.get_items(get_item_ids(all_bids))
    @bid_items = zip_bids_items(all_bids,all_items)
  end

  def get_bids_for_user(user_id)
    Bid.where(user_id: user_id)
  end

  def get_item_ids(bids)
    bids.collect { |b| b.item_id }
  end

  def zip_bids_items(all_bids, all_items)
    zip = []
    all_items.each_with_index { |item, idx|
      if !item.nil?
        check_if_auction_ended(item) if !item.sold
        zip << [all_bids[idx], item]
      end
    }
    zip
  end

  def check_if_auction_ended(item)
    if !(item.end_datetime >= Time.now)
      ItemsController.new.update_item_auction_local(item)
    end
  end
end
