class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.references :order, null: false, foreign_key: true
      t.jsonb :metadata, default: {}
      t.integer :status, null: false, default: 0
      t.datetime :processed_at
      t.string :operation_id

      t.timestamps
    end
  end
end
