# frozen_string_literal: true

RSpec.describe CategoriesController, type: :controller do
  describe 'GET #index' do
    context 'when success ' do
      before { get :index }

      it 'returns 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders show template' do
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'GET #show ' do
    let(:category) { create(:category) }
    let(:books) { create_list(:book, 3, category: category) }

    before { get :show, params: { id: category } }

    it 'assigns the requested book to  @book' do
      expect(assigns(:books)).to eq(books)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
