FactoryBot.define do
  factory :peer_reviews_participation, class: "PeerReviews::Participation" do
    user { nil }
    peer_review { nil }
    hashid { "MyString" }
    comment { "MyText" }
  end
end
