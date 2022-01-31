FactoryBot.define do
  factory :student_profile do
    student_number { Faker::Number.number(digits: 5).to_s }
    user
  end
end
