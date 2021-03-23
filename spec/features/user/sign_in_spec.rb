# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign in', '
    In order to ask question as an unauthenticated user
    I`d like to be able to sign in
' do
  given(:user) { create(:user) }

  background { visit new_user_session_path }

  scenario 'Registered user tries to sign in' do
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Log in'

    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Unregistered user tries to sign in' do
    fill_in 'email', with: 'wrong@test.com'
    fill_in 'email', with: '123456aaAA'
    click_button 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
  end
end
