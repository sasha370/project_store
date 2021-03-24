# frozen_string_literal: true

RSpec.describe BooksController, type: :controller do
  describe 'GET #index' do
    let(:books) { create_list(:book, 12) }
    before { get :index }

    it 'populate an array of all books' do
      expect(assigns(:books)).to match_array(books)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: book } }
    let(:book) { create(:book) }

    it 'assigns the requested book to  @book' do
      expect(assigns(:book)).to eq(book)
    end

    # it 'assigns new comment for question' do
    # expect(assigns(:comment)).to be_a_new(Comment)
    # end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
