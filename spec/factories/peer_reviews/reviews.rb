FactoryBot.define do
  factory :peer_reviews_review, class: "PeerReviews::Review" do
    fun { Faker::Number.between from: 1, to: 5 }
    technical { Faker::Number.between from: 1, to: 5 }
    creativity { Faker::Number.between from: 1, to: 5 }
    composition { Faker::Number.between from: 1, to: 5 }
    growth { Faker::Number.between from: 1, to: 5 }
    comment { Faker::Lorem.paragraph }
    peer_review
    association :reviewer_participation, factory: :peer_reviews_participation
    association :reviewee_participation, factory: :peer_reviews_participation
  end
end
