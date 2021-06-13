require 'rails_helper'

RSpec.describe Purchasment, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:project) }
end
