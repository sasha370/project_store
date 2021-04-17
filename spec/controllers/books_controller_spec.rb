# frozen_string_literal: true

RSpec.describe BooksController, type: :controller do
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
