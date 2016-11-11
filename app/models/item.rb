class Item < ApplicationRecord
  validate :date_two_after_date_one, :start_date_in_future

  def date_two_after_date_one
    errors.add :end_date, 'should be after start date' if end_datetime < start_datetime
  end

  def start_date_in_future
    errors.add :start_date, 'should be after start date' if start_datetime < Date.today
  end
end