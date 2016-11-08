class AuctionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def find_user_auction_items(user_id)
    auctions = Auction.where(user_id: user_id, valid_auction: true)
    if !auctions.nil?
      auctions.map { |auc| Item.find_by_id(auc.item_id) }
    else
      nil
    end
  end

  def create_auction_for_item(user_id, item_id)
    auction = Auction.new(user_id: user_id, item_id: item_id, valid_auction: true)
    auction.save
  end
end
