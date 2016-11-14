class AddColumnWinnerToItems < ActiveRecord::Migration
  def change
    change_table :items do |t|
      t.column :winner, :integer
    end
  end
end
