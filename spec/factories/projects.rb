# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    category
    association :author, factory: :user
    title { FFaker::Book.title }
    short_description { FFaker::Lorem.paragraphs(1) }
    description { FFaker::Lorem.paragraphs(3) }
    price { rand(1..1000) }
    old_price { rand(1..1000) }
    dimentions { '1000x111x222' }
    difficulty { rand(0..5) }
    materials { %w[plastic wood papper].sample }
  end
end
