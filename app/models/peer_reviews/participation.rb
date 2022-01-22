module PeerReviews
  class Participation < ApplicationRecord
    belongs_to :user
    belongs_to :peer_review
  end
end
