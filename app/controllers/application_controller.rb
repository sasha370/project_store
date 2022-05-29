# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action do
    Rack::MiniProfiler.authorize_request if current_user&.admin?
  end

  protected

  def authenticate_admin_user!
    authenticate_user!
    return unless current_user.role == 'usual'

    flash[:alert] = t('alerts.unauthorized')
    redirect_to root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation, :login, :avatar)
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation, :login, :avatar)
    end
  end

  private

  def transfer_guest_to_user
    # After this block runs, the guest_user will be destroyed!
    # Cart from guest_user will be added to current user

    if current_user.cart
      guest_user.cart.order_projects.each { |order_project| order_project.update(order_id: current_user.cart.id) }
      current_user.cart.update_amount
    else
      guest_user.cart.update!(user: current_user)
    end
  end
end
