class PeerReviews::Review < ApplicationRecord
  belongs_to :peer_review
  belongs_to :reviewer
  belongs_to :reviewee
end
