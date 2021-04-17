# frozen_string_literal: true

RSpec.describe Book, type: :model do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :author }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to belong_to(:category) }
end
