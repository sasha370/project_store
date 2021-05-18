# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    title { 'Test_Category' }
    description { FFaker::Lorem.paragraphs(1) }
  end
end
