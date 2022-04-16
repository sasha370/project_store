# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    category
    status { :published }
    title { FFaker::Book.title }
    short_description { FFaker::Lorem.paragraphs(1) }
    description { FFaker::Lorem.paragraphs(3) }
    price { rand(1..1000) }
    old_price { rand(1..1000) }
    dimensions { '1000x111x222' }
    difficulty { rand(0..5) }
    materials { %w[plastic wood papper].sample }
    images do
      Array.new(5) { Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/files/images/default_cover#{rand(0 - 6)}.jpg"), 'image/jpeg') }
    end
  end
end
