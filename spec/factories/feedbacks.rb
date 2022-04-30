# frozen_string_literal: true

FactoryBot.define do
  factory :feedback do
    body { 'MyText' }
    title { 'MyString' }
    user
  end
end
