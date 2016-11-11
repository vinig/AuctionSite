class AuctionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def find_user_auction_items(user_id, is_seller)
    if is_seller
      auctions = Auction.where(user_id: user_id, valid_auction: true)
    else
      auctions = Auction.where(valid_auction: true, approved: true)
    end

    if !auctions.nil?
      auctions.map { |auc| Item.find_by_id(auc.item_id) }
    else
      nil
    end
  end

  def approve_item
    auction = Auction.find_by_item_id(params[:id])
    val = auction.approved
    auction.update_attributes(approved: !val)
    auction.save
    redirect_to item_path(id: params[:id])
  end

  def create_auction_for_item(user_id, item_id, validity)
    auction = Auction.new(user_id: user_id, item_id: item_id, valid_auction: validity)
    auction.save
  end
end
