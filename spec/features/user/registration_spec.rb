# frozen_string_literal: true

require 'rails_helper'

feature 'Guest can sign up', '
    To use the full functionality, I`d must be able to register
' do
  scenario 'Guest tries to register with correct data' do
    visit new_user_registration_path
    fill_in 'Email', with: 'tests@test.ru'
    fill_in 'Password', with: '123456aaAA'
    fill_in 'Password confirmation', with: '123456aaAA'
    click_on 'Sign up'

    expect(page).to have_content 'My account'
  end

  describe 'Guest already registered' do
    given(:user) { create(:user) }

    scenario 'tries to reRegister as new user' do
      visit new_user_registration_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: '123456aaAA'
      fill_in 'Password confirmation', with: '123456aaAA'
      click_on 'Sign up'

      expect(page).to have_content 'Email has already been taken'
    end
  end

  describe 'Register with Omniauth services' do
    # describe 'Facebook' do
    #   scenario 'with correct data' do
    #     mock_auth_hash('github', email: 'test@test.ru')
    #     visit new_user_registration_path
    #     click_link "Sign in with GitHub"

    #     expect(page).to have_content 'Successfully authenticated from GitHub account.'
    #   end

    #   scenario "can handle authentication error with GitHub" do
    #     invalid_mock('github')
    #     visit new_user_registration_path
    #     click_link "Sign in with GitHub"
    #     expect(page).to have_content 'Could not authenticate you from GitHub because "Invalid credentials"'
    #   end
    # end
  end
end
