# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      connect_to('Facebook')
    end

    private

    def connect_to(provider)
      auth = request.env['omniauth.auth']
      return redirect_to root_path, alert: 'Something went wrong' if auth == :invalid_credentials || auth.nil?

      @user = FindForOauthService.new(auth).call
      if @user&.persisted?
        sign_in_and_redirect @user, event: :authenticate
        set_flash_message(:notice, :success, kind: provider.to_s)
      else
        session[:auth] = auth.except('extra')
        redirect_to new_user_registration_url, alert: 'We don`t found email in your`s profile, please register'
      end
    end
  end
end
