# frozen_string_literal: true

RSpec.describe 'Book', type: :feature do
  describe 'User can visit Catalog pages', '
    To see books by categories, I`d must be able to select it in catalog
' do
    context 'when goes directly to Catalog' do
      it 'success' do
        visit(books_path)
        expect(page).to have_content t('books.index.page_title')
      end
    end

    context 'when looking only category`s books' do
      let(:category1) { create(:category, title: 'First category') }
      let(:category2) { create(:category, title: 'Second category') }
      let!(:book1) { create(:book, category: category1) }
      let!(:book2) { create(:book, category: category2) }

      it 'includes First Category`s books' do
        visit(books_path(category_id: category1))
        expect(page).to have_content book1.title
        expect(page).not_to have_content book2.title
      end

      it 'includes All Category`s books' do
        visit(books_path)
        expect(page).to have_content book1.title
        expect(page).to have_content book2.title
      end
    end

    context 'when click view more button' do
      let(:category) { create(:category) }
      let!(:books) { create_list(:book, 15, category: category) }

      it 'show only per_page books', js: true do
        visit(books_path)
        books.first(BooksController::PER_PAGE).each do |book|
          expect(page).to have_content book.title
        end
      end

      it 'show more books', js: true do
        visit(books_path)
        click_link t('books.index.view_more')
        books.each do |book|
          expect(page).to have_content book.title
        end
      end
    end
  end
end
