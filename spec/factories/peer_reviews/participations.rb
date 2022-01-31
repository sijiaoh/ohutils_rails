FactoryBot.define do
  factory :peer_reviews_participation, class: "PeerReviews::Participation" do
    comment { Faker::Lorem.paragraph }
    user
    peer_review
  end
end
