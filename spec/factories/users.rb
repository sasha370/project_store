# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    phone { FFaker::PhoneNumberRU.international_mobile_phone_number }
    password { 'A123456a' }
    password_confirmation { 'A123456a' }
    first_name { FFaker::NameRU.first_name }
    last_name { FFaker::NameRU.last_name }
    confirmed_at { Time.zone.today }
  end
end
