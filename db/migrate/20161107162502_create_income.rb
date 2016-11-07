class CreateIncome < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.belongs_to :user
      t.decimal :income, precision: 10, scale: 2
    end
  end
end
