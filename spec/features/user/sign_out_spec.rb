# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign out' do
  given(:user) { create(:user) }

  scenario 'Logined user tries to log out' do
    sign_in(user)
    first(:link, 'Log out').click
    expect(page).to have_content 'Signed out successfully.'
  end
end
