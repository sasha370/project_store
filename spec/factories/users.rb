FactoryBot.define do
  sequence :email do |n|
    "user#{n}@mail.ru"
  end

  factory :user do
    email
    password { '123456' }
    password_confirmation { '123456' }
    first_name {'Bilbo'}
    last_name {'Baggins'}
    phone {'+79999999999'}
  end
end