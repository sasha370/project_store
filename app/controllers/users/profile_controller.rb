# frozen_string_literal: true

module Users
  class ProfileController < ApplicationController
    def my_orders
      @orders = current_user.paid_orders.includes(:projects).decorate if current_user
    end
  end
end
