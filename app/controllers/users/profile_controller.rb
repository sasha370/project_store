# frozen_string_literal: true

module Users
  class ProfileController < ApplicationController
    def my_orders
      if current_user
        @orders = current_user.orders.paid.includes(:project)
      else
        redirect_to root_path, notice: 'You need to be authorized'
      end
    end
  end
end
