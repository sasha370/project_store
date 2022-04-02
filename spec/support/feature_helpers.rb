# frozen_string_literal: true

module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password

    click_button I18n.t('.devise.buttons.log_in')
  end
end
