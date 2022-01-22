module PeerReviews
  class Participation < ApplicationRecord
    include HashidSluggable

    belongs_to :user
    belongs_to :peer_review
  end
end
