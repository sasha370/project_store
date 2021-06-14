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
        expect(response).to render_template 'add_to_cart'
      end
    end

    context 'when NOT Auth user' do
      before do
        get :add_to_cart, params: { id: project.id }, format: :js
      end

      it 'returns 200 status' do
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
        expect(response).to render_template 'add_to_cart'
      end
    end
  end

  describe 'GET #cart' do
    let(:project) { create(:project) }
    let(:user) { create(:user) }
    let!(:purchasment) { create(:purchasment, user: user, project: project, status: 0) }
    let!(:purchasment_paid) { create(:purchasment, user: user, project: project, status: 10) }
    let!(:purchasment2) { create(:purchasment) }

    context 'when Auth user' do
      before do
        login(user)
        get :cart
      end

      it 'returns 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'assigns the purchasements to purchasements ( without paid)' do
        expect(assigns(:purchasments)).to eq([purchasment])
      end

      it 'assigns the purchasements to have not  others purchasements' do
        expect(assigns(:purchasments)).not_to include(purchasment_paid, purchasment2)
      end
    end

    context 'when NOT Auth user' do
      before do
        get :cart
      end

      it 'redirect to root' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #remove_from_cart' do
    let(:project) { create(:project) }
    let(:user) { create(:user) }
    let!(:purchasment) { create(:purchasment, user: user, project: project) }

    context 'when remove from cart' do
      before do
        login(user)
        get :remove_from_cart, params: { id: purchasment.id }, format: :js
      end

      it 'returns 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'assigns the purchasment to @purchasment' do
        expect(assigns(:purchasment)).to eq(purchasment)
      end

      it 'assigns the purchase to @purchase' do
        expect(Purchasment.count).to eq(0)
      end
    end
  end
end
