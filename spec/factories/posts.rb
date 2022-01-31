FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    published { false }
    user
    space

    trait :published do
      published { true }
    end
  end
end
