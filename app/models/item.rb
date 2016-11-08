class Item < ApplicationRecord
  validate :date_two_after_date_one

  def date_two_after_date_one
    errors.add :end_date, 'should be after start date' if end_datetime < start_datetime
  end
end