FactoryBot.define do
  sequence :email do |n|
    "user#{n}@mail.ru"
  end

  factory :user do
    email
    password { '123456aaA' }
    password_confirmation { '123456aaA' }
  end
end