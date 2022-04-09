# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def authenticate_admin_user!
    authenticate_user!
    return unless current_user.role == 'usual'

    flash[:alert] = 'Unauthorized Access!'
    redirect_to root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation, :login)
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation, :login, :avatar)
    end
  end
end
