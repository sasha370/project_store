# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_projects, dependent: :destroy
  has_many :projects, through: :order_projects
  belongs_to :user
  has_one :payment, dependent: :destroy

  enum status: { cart: 0, paid: 10 }

  def total_amount
    projects.sum(:price)
  end

  def amount_with_discount
    total_amount - discount
  end

  def update_amount
    update(amount: amount_with_discount)
  end
end
