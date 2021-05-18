# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.string :short_description, null: false
      t.text :description, null: false
      t.decimal :price, null: false
      t.decimal :old_price
      t.string :dimentions
      t.integer :difficulty, null: false
      t.string :materials
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
