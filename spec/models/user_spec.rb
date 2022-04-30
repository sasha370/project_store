# frozen_string_literal: true

RSpec.describe User, type: :model do
  let(:user) { create :user }

  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to have_many(:orders) }
  it { is_expected.to have_many(:feedbacks) }

  describe '#qty_in_cart' do
    let!(:order) { create :order, :with_items, user: user }

    it { expect(user.qty_in_cart).to eq(order.projects.count) }
  end

  describe '#cart' do
    it 'create new cart if it doesn`t exist' do
      expect(user.cart).to be_a Order
    end

    describe 'finds existing cart' do
      let!(:cart) { create :order, user: user }

      it { expect(user.cart).to eq(cart) }
    end
  end

  describe '#paid_orders' do
    let!(:paid_orders) { create_list :order, 2, user: user, status: :paid }

    it { expect(user.paid_orders).to eq(paid_orders) }
  end
end
