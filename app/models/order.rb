# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_projects, dependent: :destroy
  has_many :projects, through: :order_projects
  belongs_to :user
  has_one :payment, dependent: :destroy

  # before_save :calculate_discount, if: -> { price_changed? } # TODO, WTF?
  enum status: { cart: 0, paid: 10 }

  def calculate_discount
    self.discount = project.price - price
  end

  def total_amount
    projects.sum(:price)
  end

  def amount_with_discount
    total_amount - discount
  end
end
