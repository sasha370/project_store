# frozen_string_literal: true

RSpec.describe OrdersController, type: :controller do
  describe 'GET #add_to_cart' do
    let!(:project) { create(:project) }

    context 'when Auth user' do
      let!(:user) { create(:user) }

      before do
        login(user)
        get :add_to_cart, params: { id: project.id }
      end

      it 'redirect to self' do
        expect(response).to redirect_to project_path(project)
      end

      it 'assigns the user to @user' do
        expect(assigns(:current_user)).to eq(user)
      end

      it 'creates a cart' do
        expect(user.orders.cart.size).to eq(1)
        expect(user.orders.last.order_projects.first.project).to eq(project)
      end
    end

    context 'when NOT Auth user' do
      before do
        get :add_to_cart, params: { id: project.id }
      end

      it 'assigns the projects to @cart' do
        expect(User.last.cart.projects).to eq([project])
      end

      it 'redirect to self' do
        expect(response).to redirect_to project_path(project)
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

      it 'not redirect to sign_in' do
        expect(response).to render_template 'orders/cart'
      end
    end
  end

  describe 'GET #remove_from_cart' do
    let(:user) { create(:user) }
    let!(:order) { create(:order, :with_items, user: user) }
    let(:order_project_to_remove) { order.order_projects.first }
    let(:perform) { get :remove_from_cart, params: { id: order_project_to_remove.id } }

    context 'when remove from cart' do
      before do
        login(user)
      end

      it 'redirect to /cart' do
        perform
        expect(response).to redirect_to cart_path
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
      let(:perform) { get :remove_from_cart, params: { id: order_project_to_remove.id } }

      it 'redirect to /cart' do
        perform
        expect(response).to redirect_to cart_path
      end

      it 'change order_project count' do
        expect { perform }.to change(OrderProject, :count).by(-1)
      end
    end
  end
end
