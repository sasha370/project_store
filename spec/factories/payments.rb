# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    order
    metadata { '' }
    status { 0 }
  end
end
