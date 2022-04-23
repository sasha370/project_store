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
    images do
      Array.new(5) do
        file_path = Rails.root.join("spec/fixtures/files/images/default_cover#{rand(0 - 6)}.jpg")
        Rack::Test::UploadedFile.new(file_path, 'image/jpeg')
      end
    end

    trait :with_archive do
      after :build do |project|
        file_name = 'logo.png'
        file_path = Rails.root.join('spec/fixtures/files/uploads', file_name)
        project.archive.attach(io: File.open(file_path), filename: file_name, content_type: 'image/png')
      end
    end
  end
end
