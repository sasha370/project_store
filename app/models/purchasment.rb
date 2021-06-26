# frozen_string_literal: true

class Purchasment < ApplicationRecord
  belongs_to :project
  belongs_to :user

  before_save :calculate_discount, if: -> { price_changed? }
  enum status: { in_cart: 0, paid: 10 }

  private

  def calculate_discount
    self.discount = project.price - price
  end
end
