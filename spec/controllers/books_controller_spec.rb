# frozen_string_literal: true

RSpec.describe BooksController, type: :controller do
  describe 'GET #index' do
    context 'when success ' do
      before { get :index }

      it 'returns 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders show template' do
        expect(response).to render_template(:index)
      end
    end

    context 'with books' do
      let(:category1) { create(:category) }
      let(:category2) { create(:category) }
      let(:books1) { create_list(:book, 3, category: category1) }
      let(:books2) { create_list(:book, 3, category: category2) }

      it 'assigns the requested books to ALL @books' do
        get :index
        expect(assigns(:books)).to eq(books1 + books2)
      end

      it 'assigns the requested books to Category`s @books' do
        get :index, params: { category_id: category1.id }
        expect(assigns(:books)).to eq(books1)
      end
    end

    context 'with out books' do
      it 'assigns the requested books empty' do
        get :index
        expect(assigns(:books)).to eq([])
      end
    end
  end

  describe 'GET #show' do
    let(:book) { create(:book) }

    before { get :show, params: { id: book } }

    it 'assigns the requested book to  @book' do
      expect(assigns(:book)).to eq(book)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
