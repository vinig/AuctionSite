module ItemsHelper
  include ActionView::Helpers::NumberHelper
  def datetime_formatter(datetime)
    datetime.strftime("%m-%d-%Y")
  end

  def price_formatter(price)
    number_to_currency(price, preicison: 2)
  end

  def item_approved?(item_id)
    Auction.find_by_item_id(item_id).approved
  end

  def auction_eligible?(item_id)
    auction = Auction.find_by_item_id(item_id)
    auction.valid_auction && auction.approved
  end

  def item_valid?(item_start_datetime)
    item_start_datetime >= Date.today
  end
end
