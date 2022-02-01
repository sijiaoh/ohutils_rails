FactoryBot.define do
  factory :user do
    name { Faker::Internet.username }

    trait :admin do
      after :create do |user|
        user.add_role :admin
      end
    end

    trait :student do
      after :create do |user|
        user.add_role :student
      end
    end
  end
end
