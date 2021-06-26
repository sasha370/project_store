class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true
      t.jsonb :metadata, default: {}
      t.integer :amount, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
