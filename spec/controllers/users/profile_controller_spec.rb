# frozen_string_literal: true

RSpec.describe Users::ProfileController, type: :controller do
  describe 'GET#my_orders' do
    let(:user) { create(:user) }
    let(:order) { create(:order, :with_items, user: user, status: 10) }
    let(:not_paid_order) { create(:order, :with_items, user: user, status: 0) }

    before do
      not_paid_order
      login(user)
    end

    it 'assigns only paid orders' do
      get :my_orders
      expect(assigns(:orders)).to eq([order])
    end
  end

  describe '#save_email' do
    let(:email) { 'some_email@scom.com' }
    let(:perform) { post :save_email, params: { email: email } }

    context 'when email already exist' do
      before { create :user, email: email }

      it 'redirect to login page' do
        expect(perform).to redirect_to new_user_session_path
      end
    end

    context 'when email is new' do
      it 'create new user' do
        perform
        expect(User.last.email).to eq(email)
      end

      it 'redirect to cart' do
        perform
        expect(perform).to redirect_to cart_path
      end
    end
  end
end
