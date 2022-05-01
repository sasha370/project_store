# frozen_string_literal: true

RSpec.describe 'Profile', type: :feature do
  let!(:user) { create(:user) }

  describe 'User can register with avatar' do
    it 'successfully' do
      visit(new_user_registration_path)
      file_path = Rails.root.join('spec/fixtures/files/images/avatar.png')
      attach_file('user_avatar', file_path)
      fill_in :user_first_name, with: 'Name'
      fill_in :user_last_name, with: 'Second name'
      fill_in :user_email, with: 'my_email@email.com'
      fill_in :user_password, with: '123456'
      fill_in :user_password_confirmation, with: '123456'
      click_button I18n.t('devise.shared.links.sign_up')
      expect(page).to have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
    end
  end

  describe 'User can edit his profile' do
    it 'without password confirmation' do
      sign_in user
      visit(edit_user_registration_path)
      fill_in :user_first_name, with: 'New name'
      fill_in :user_last_name, with: 'New second name'
      click_button I18n.t('devise.registrations.edit.update')
      expect(page).to have_content I18n.t('devise.registrations.updated')
    end
  end

  describe 'and upload new avatar' do
    it 'successfully' do
      sign_in user
      visit(edit_user_registration_path)
      file_path = Rails.root.join('spec/fixtures/files/images/avatar.png')
      attach_file('user_avatar', file_path)
      click_button I18n.t('devise.registrations.edit.update')
      expect(page).to have_content I18n.t('devise.registrations.updated')
    end
  end
end
