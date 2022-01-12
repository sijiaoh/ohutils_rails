FactoryBot.define do
  factory :space do
    name { Faker::Book.title }
  end
end
