# frozen_string_literal: true

module Users
  class ProfileController < ApplicationController
    def my_purchasments
      if current_user
        @purchasments = current_user.purchasments.paid.includes(:project)
      else
        redirect_to root_path, notice: 'You need to be authorized'
      end
    end
  end
end
