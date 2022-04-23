# frozen_string_literal: true

RSpec.describe 'Pages', type: :feature do
  describe 'User can visit open pages', '
    To use the full functionality, I`d must be able to visit all pages
' do
    it 'Guest can visit root page' do
      visit(root_path)
      expect(page).to have_content I18n.t('pages.partials.best_sellers.title')
    end
  end
end
