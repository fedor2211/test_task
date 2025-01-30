FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    gender { :male }
    name { "name" }
    patronymic { "patronymic" }
    surname { "surname" }
    age { 25 }
    country { "country" }
    nationality { "nationality" }
  end
end
