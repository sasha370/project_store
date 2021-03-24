# frozen_string_literal: true

RSpec.describe Book, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :author }
  it { should validate_presence_of :price }
end
