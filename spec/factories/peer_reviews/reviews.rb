FactoryBot.define do
  factory :peer_reviews_review, class: "PeerReviews::Review" do
    like { Faker::Number.between from: 1, to: 5 }
    technical { Faker::Number.between from: 1, to: 5 }
    creativity { Faker::Number.between from: 1, to: 5 }
    composition { Faker::Number.between from: 1, to: 5 }
    growth { Faker::Number.between from: 1, to: 5 }
    comment { Faker::Lorem.paragraph }
  end
end
