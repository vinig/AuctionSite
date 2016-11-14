class AddColumnSoldToItems < ActiveRecord::Migration
  def change
    change_table :items do |t|
      t.column :sold, :boolean, default: false
    end
  end
end
