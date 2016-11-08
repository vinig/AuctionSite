module ItemsHelper
  include ActionView::Helpers::NumberHelper
  def datetime_formatter(datetime)
    datetime.strftime("%m-%d-%Y")
  end

  def price_formatter(price)
    number_to_currency(price, preicison: 2)
  end
end
