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

  trait :with_items_and_archive do
    after(:create) do |order|
      projects = create_list(:project, 3, :with_archive)
      order.projects << projects
    end
  end
end
