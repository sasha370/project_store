# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    photo { 'photo link' }
    title { 'Book title' }
    author { 'Test Author' }
    price { rand(1..1000) }
    quantity { rand(0..10) }
    description { 'Full description of book' }
    published_year { rand(1900..2021) }
    dimentions { '1000x111x222' }
    materials { %w[plastic wood papper].sample }
  end
end
