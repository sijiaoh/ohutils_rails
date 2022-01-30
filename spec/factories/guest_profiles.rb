FactoryBot.define do
  factory :guest_profile do
    student_number { Faker::Number.number(digits: 5).to_s }
  end
end
