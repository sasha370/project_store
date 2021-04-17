# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    category
    title { FFaker::Book.title }
    author { FFaker::Book.author }
    price { rand(1..1000) }
    quantity { rand(0..10) }
    description { FFaker::Lorem.paragraph }
    published_year { rand(1900..2021) }
    dimentions { '1000x111x222' }
    materials { %w[plastic wood papper].sample }
  end
end
