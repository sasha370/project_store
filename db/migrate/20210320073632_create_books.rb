# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.decimal :price, null: false
      t.integer :quantity
      t.text :description
      t.integer :published_year
      t.string :dimentions
      t.string :materials

      t.timestamps
    end
  end
end
