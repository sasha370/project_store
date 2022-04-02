# frozen_string_literal: true

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:projects).through(:order_projects) }
  it { is_expected.to have_many(:order_projects) }
  it { is_expected.to have_one(:payment) }
end
