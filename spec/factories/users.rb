FactoryBot.define do
  factory :user do
    name { Faker::Internet.username }
  end
end
