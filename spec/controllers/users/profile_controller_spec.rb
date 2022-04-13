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
end
