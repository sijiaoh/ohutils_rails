module PeerReviews
  module ReviewsSupport
    def fill_in_review_attributes(params)
      [*PeerReviews::Review::SCORE_KEYS, :comment].each do |key|
        fill_in PeerReviews::Review.human_attribute_name(key), with: params.public_send(key)
      end
    end
  end
end
