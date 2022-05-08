# frozen_string_literal: true

module Users
  class ProfileController < ApplicationController
    before_action :authenticate_user!, only: %i[my_orders]

    def my_orders
      @orders = current_user.paid_orders.includes(:projects).decorate
    end

    def save_email
      user = User.find_by(email: params[:email])
      if user
        flash[:notice] = t('controllers.users.profile.save_email.user_exists')
        redirect_to new_user_session_path
      else
        new_user = create_default_user(params[:email])
        sign_in(:user, new_user)
        flash[:notice] = t('controllers.users.profile.save_email.new_user')
        redirect_to cart_url
      end
    end

    private

    def create_default_user(email)
      User.create!(first_name: 'Guest',
                   password: 123_456,
                   email: email,
                   confirmed_at: Time.zone.now)
    end
  end
end
