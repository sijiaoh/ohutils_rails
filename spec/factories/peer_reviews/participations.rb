FactoryBot.define do
  factory :peer_reviews_participation, class: "PeerReviews::Participation" do
    comment { Faker::Lorem.paragraph }
  end
end
