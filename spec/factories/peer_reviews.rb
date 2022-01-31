FactoryBot.define do
  factory :peer_review do
    title { Faker::Book.title }

    space
  end
end
