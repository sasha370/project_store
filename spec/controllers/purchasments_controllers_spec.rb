# frozen_string_literal: true

RSpec.describe PurchasmentsController, type: :controller do
  describe 'GET #add_to_cart' do
    let!(:project) { create(:project) }
    let!(:user) { create(:user) }

    context 'when Auth user' do
      before do
        login(user)
        get :add_to_cart, params: { id: project.id }, format: :js
      end

      it 'returns 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'assigns the user to @user' do
        expect(assigns(:current_user)).to eq(user)
      end

      it 'assigns the project to @project' do
        expect(assigns(:project)).to eq(project)
      end

      it 'assigns the purchase to @purchase' do
        expect(Purchasment.count).to eq(1)
      end

      it 'redirect_to @project' do
        expect(@responce).to render_template 'add_to_cart'
      end
    end

    context 'when NOT Auth user' do
      before do
        get :add_to_cart, params: { id: project.id }, format: :js
      end

      it 'returns 400 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'assigns the user to @user' do
        expect(assigns(:current_user)).to eq(nil)
      end

      it 'assigns the project to @project' do
        expect(assigns(:project)).to eq(nil)
      end

      it 'assigns the purchase to @purchase' do
        expect(Purchasment.count).to eq(0)
      end

      it 'redirect_to @project' do
        expect(@responce).to render_template 'add_to_cart'
      end
    end
  end
end
