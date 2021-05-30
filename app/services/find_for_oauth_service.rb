# frozen_string_literal: true

class FindForOauthService
  def initialize(auth)
    @auth = auth
  end

  def call
    return if @auth['invalid_credentials']

    return @user if find_user_by_authorization

    set_user
  end

  private

  def set_user
    user = User.where(email: email).first
    if user
      create_authorization(@auth, user)
    elsif email
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, first_name: (@auth.dig('info', 'first_name') || 'Гость'),
                          password: password, password_confirmation: password, confirmed_at: Time.zone.now)
      create_authorization(@auth, user)
    end
    user
  end

  def email
    @email ||= @auth.dig('info', 'email')
  end

  def find_user_by_authorization
    authorization = Authorization.where(provider: @auth['provider'], uid: @auth['uid'].to_s).first
    authorization ? @user = authorization.user : false
  end

  def create_authorization(auth, user)
    user.authorizations.create(provider: auth['provider'], uid: auth['uid'].to_s)
  end
end
