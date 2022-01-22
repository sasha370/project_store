# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    user { nil }
    metadata { '' }
    amount { 1 }
    status { 1 }
    label { 'MyString' }
  end
end
