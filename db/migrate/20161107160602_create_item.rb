class CreateItem < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.datetime :start_datetime
      t.datetime :end_datetime
    end
  end
end
