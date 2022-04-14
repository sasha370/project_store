class AddDefaultToAmountTableOrder < ActiveRecord::Migration[6.1]
  def change
    Order.select(amount: nil).update_all(amount: 0)

    change_column :orders, :amount, :integer, :default => 0,  null: false
  end
end
