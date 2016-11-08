class RenameValidColumnInAuctions < ActiveRecord::Migration
  def change
    rename_column :auctions, :valid, :valid_auction
  end
end
