# frozen_string_literal: true

RSpec.describe Category, type: :model do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to have_many(:projects) }
end
