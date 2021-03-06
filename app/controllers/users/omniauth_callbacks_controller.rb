# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      return redirect_to root_path, alert: t('alerts.wrong_msg') if auth == :invalid_credentials || auth.nil?

      connect_to('Facebook')
    end

    private

    def connect_to(provider)
      @user = FindForOauthService.new(auth).call

      if @user&.persisted?
        sign_in_and_redirect @user, event: :authenticate
        set_flash_message(:notice, :success, kind: provider.to_s)
      else
        session[:auth] = auth.except('extra')
        redirect_to new_user_registration_url, alert: t('alerts.email_not_found')
      end
    end

    def auth
      @auth ||= request.env['omniauth.auth']
    end
  end
end
