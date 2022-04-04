# frozen_string_literal: true

RSpec.describe OrdersController, type: :controller do
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

      it 'creates a cart' do
        expect(user.orders.cart.size).to eq(1)
        expect(user.orders.last.order_projects.first.project).to eq(project)
      end

      it 'render notification' do
        expect(response).to render_template 'add_to_cart'
      end
    end

    context 'when NOT Auth user' do
      before do
        get :add_to_cart, params: { id: project.id }, format: :js
      end

      it 'returns 401 status' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'assigns the user to @user' do
        expect(assigns(:current_user)).to be_nil
      end

      it 'assigns the purchase to @purchase' do
        expect(user.orders.cart.size).to eq(0)
      end

      it 'redirect_to @project' do
        expect(response).not_to render_template 'add_to_cart'
      end
    end
  end

  describe 'GET #cart' do
    let(:project) { create(:project) }
    let(:user) { create(:user) }
    let!(:new_order) { create(:order, :with_items, user: user) }
    let(:create_paid_order) { create(:order, :with_items, user: user, status: 10) }

    context 'when Auth user' do
      before do
        login(user)
        create_paid_order
        get :cart
      end

      it 'returns 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'assigns the new_order to @cart (without paid)' do
        expect(assigns(:cart)).to eq(new_order)
      end

      it 'assigns the @order_projects' do
        expect(assigns(:order_projects)).to eq(new_order.order_projects)
      end

      it 'order has a payment' do
        expect(new_order.payment).to be_an_instance_of(Payment)
      end
    end

    context 'when NOT Auth user' do
      before do
        get :cart
      end

      it 'redirect to sign_in' do
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe 'GET #remove_from_cart' do
    let(:user) { create(:user) }
    let!(:order) { create(:order, :with_items, user: user) }
    let(:order_project_to_remove) { order.order_projects.first }
    let(:perform) { get :remove_from_cart, params: { id: order_project_to_remove.id }, format: :js }

    context 'when remove from cart' do
      before do
        login(user)
      end

      it 'returns 200 status' do
        perform
        expect(response).to have_http_status(:ok)
      end

      it 'assigns the order_project to @order_project' do
        perform
        expect(assigns(:order_project)).to eq(order_project_to_remove)
      end

      it 'assigns the purchase to @purchase' do
        expect { perform }.to change(OrderProject, :count).by(-1)
      end
    end

    context 'when NOT Auth' do
      let(:perform) { get :remove_from_cart, params: { id: order_project_to_remove.id }, format: :js }

      it 'returns 401 status' do
        perform
        expect(response).to have_http_status(:unauthorized)
      end

      it 'not change orders count' do
        expect { perform }.not_to change(OrderProject, :count)
      end
    end
  end
end
