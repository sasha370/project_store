# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    user
    status { 0 }
  end

  trait :with_items do
    after(:create) do |order|
      create_list(:order_project, 3, order: order)
    end
  end
end
