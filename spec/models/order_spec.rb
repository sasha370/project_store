# frozen_string_literal: true

RSpec.describe Order, type: :model do
  let(:order) { create :order }
  let(:projects) { create_list :project, 3, price: 1000 }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:projects).through(:order_projects) }
  it { is_expected.to have_many(:order_projects) }
  it { is_expected.to have_one(:payment) }

  describe '#total_amount' do
    before { order.projects << projects }

    it 'calculates amount for all order`s projects' do
      expect(order.total_amount).to eq(3000)
    end
  end

  describe '#amount_with_discount' do
    let(:order) { create :order, discount: 300 }

    before { order.projects << projects }

    it 'calculates amount for all order`s projects' do
      expect(order.amount_with_discount).to eq(2700)
    end
  end
end
