# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    price { rand(1..1000) }
    quantity { rand(0..10) }
    description { Faker::Lorem.sentence(word_count: rand(20..50)) }
    published_year { rand(1900..2021) }
    dimentions { '1000x111x222' }
    materials { %w[plastic wood papper].sample }
  end
end
