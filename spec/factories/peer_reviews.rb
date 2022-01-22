FactoryBot.define do
  factory :peer_review do
    title { Faker::Book.title }

    trait :with_space do
      space { build :space }
    end
  end
end
