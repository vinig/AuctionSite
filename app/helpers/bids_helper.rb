module BidsHelper
  include ActionView::Helpers::NumberHelper
  def precision_formatter(price)
    number_with_precision(price, precision: 2)
  end
end
