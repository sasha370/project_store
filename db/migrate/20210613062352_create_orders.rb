class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, index: true
      t.references :promocode
      t.integer :amount
      t.integer :discount, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
