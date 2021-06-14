# frozen_string_literal: true

module ApplicationHelper
  def item_in_cart
    current_user.purchasments.in_cart.count
  end
end
