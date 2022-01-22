# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.string :short_description, null: false
      t.text :description, null: false
      t.integer :price, null: false
      t.integer :old_price
      t.integer :cost_price
      t.string :dimensions
      t.integer :difficulty, null: false
      t.string :materials
      t.integer :status, default: 0, null: false
      t.boolean :hit, default: false, null: false

      t.timestamps
    end
  end
end
