module IncomeHelper
  include ActionView::Helpers::NumberHelper
  def price_formatter(price)
    number_to_currency(price, preicison: 2)
  end
end
