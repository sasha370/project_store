# frozen_string_literal: true

RSpec.describe Project, type: :model do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :short_description }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :difficulty }
  it { is_expected.to validate_presence_of :status }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to belong_to(:category) }
  it { is_expected.to belong_to(:author) }
end
