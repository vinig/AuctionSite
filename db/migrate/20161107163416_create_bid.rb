class CreateBid < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.belongs_to :user
      t.belongs_to :item
      t.decimal :price, precision: 10, scale: 2
    end
  end
end
