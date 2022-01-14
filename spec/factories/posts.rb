FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    published { false }

    trait :with_space do
      space { build :space }
    end
  end
end
