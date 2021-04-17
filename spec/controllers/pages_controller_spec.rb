# frozen_string_literal: true

RSpec.describe PagesController, type: :controller do
  describe '#index' do
    context 'when success ' do
      before { get :index }

      it 'returns 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders index template' do
        expect(response).to render_template(:index)
      end
    end
  end
end
