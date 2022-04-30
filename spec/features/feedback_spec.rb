# frozen_string_literal: true

RSpec.describe 'Feedback', type: :feature do
  let(:user) { create(:user) }

  describe 'Authorized user can add feedback' do
    before do
      sign_in user
    end

    it 'with success' do
      visit(new_feedback_path)
      fill_in :feedback_title, with: 'Some title'
      fill_in :feedback_body, with: 'Some body'
      click_button I18n.t('pages.feedback.submit')
      expect(page).to have_content I18n.t('alerts.feedback')
    end
  end

  describe 'Not authorized user cannot add feedback' do
    it 'and will redirect to log in page' do
      visit(new_feedback_path)
      expect(page).not_to have_content I18n.t('pages.feedback.submit')
      expect(page).to have_content I18n.t('devise.sessions.new.sign_in')
    end
  end
end
