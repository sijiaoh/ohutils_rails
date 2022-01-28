module PeerReviews
  class Participation < ApplicationRecord
    include HashidSluggable

    belongs_to :user
    belongs_to :peer_review

    has_many(
      :sended_reviews,
      class_name: "PeerReviews::Review",
      foreign_key: :reviewer_participation_id,
      inverse_of: :reviewer_participation,
      dependent: :destroy
    )
    has_many(
      :received_reviews,
      class_name: "PeerReviews::Review",
      foreign_key: :reviewee_participation_id,
      inverse_of: :reviewee_participation,
      dependent: :destroy
    )
  end
end
