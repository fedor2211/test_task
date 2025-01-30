FactoryBot.define do
  factory :interest do
    sequence(:name) { |n| "name-#{n}" }
  end
end
