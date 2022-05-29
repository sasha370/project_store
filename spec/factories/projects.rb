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

    after :build do |project|
      7.times do |index|
        file_name = "default_cover#{index}.jpg"
        file_path = Rails.root.join("spec/fixtures/files/images/#{file_name}")
        project.images.attach(io: File.open(file_path), filename: file_name, content_type: 'image/png')
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
