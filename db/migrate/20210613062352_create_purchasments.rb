class CreatePurchasments < ActiveRecord::Migration[6.1]
  def change
    create_table :purchasments do |t|
      t.references :project, null: false, index: true
      t.references :user, null: false, index: true
      t.references :promocode
      t.integer :price
      t.integer :discount
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
