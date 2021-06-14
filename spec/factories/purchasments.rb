# frozen_string_literal: true

FactoryBot.define do
  factory :purchasment do
    project
    user
    status { 0 }
  end
end
