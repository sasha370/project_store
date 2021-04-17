# frozen_string_literal: true

RSpec.describe 'Category', type: :feature do
  describe 'User can visit Category pages', '
    To see books by categories, I`d must be able to select it in catalog
' do
    context 'when goes directly' do
      it 'success' do
        visit(categories_path)
        expect(page).to have_content t('categories.show.page_title')
      end
    end

    context 'when looking only category`s books' do
      let(:category1) { create(:category, title: 'First category') }
      let(:category2) { create(:category, title: 'Second category') }
      let!(:book1) { create(:book, category: category1) }
      let!(:book2) { create(:book, category: category2) }

      it 'includes First Category`s books' do
        visit(category_path(category1))
        expect(page).to have_content book1.title
        expect(page).not_to have_content book2.title
      end

      it 'includes All Category`s books' do
        visit(categories_path)
        expect(page).to have_content book1.title
        expect(page).to have_content book2.title
      end
    end
  end
end
