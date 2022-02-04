module PeerReviews
  class Review < ApplicationRecord
    include HashidSluggable

    SCORE_KEYS = %i[fun technical creativity composition growth].freeze

    belongs_to :peer_review
    belongs_to :reviewer_participation, class_name: "PeerReviews::Participation"
    belongs_to :reviewee_participation, class_name: "PeerReviews::Participation"

    has_one :reviewer, through: :reviewer_participation, source: :user
    has_one :reviewee, through: :reviewee_participation, source: :user

    SCORE_KEYS.each do |key|
      validates key, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
    end
  end
end
