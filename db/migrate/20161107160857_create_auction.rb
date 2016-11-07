class CreateAuction < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.belongs_to :user
      t.belongs_to :item
      t.boolean :approved, default: false
      t.boolean :valid, default: false
    end
  end
end
