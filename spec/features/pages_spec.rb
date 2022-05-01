# frozen_string_literal: true

RSpec.describe 'Pages', type: :feature do
  describe 'User can visit open pages', '
    To use the full functionality, I`d must be able to visit all pages' do
    let(:user) { create(:user) }

    it 'Guest can visit root page' do
      visit(root_path)
      expect(page).to have_content I18n.t('pages.partials.best_sellers.title')
    end

    it 'Guest cannot visit admin page' do
      sign_in user
      visit(admin_root_path)
      expect(page).to have_content I18n.t('alerts.unauthorized')
    end
  end
end
