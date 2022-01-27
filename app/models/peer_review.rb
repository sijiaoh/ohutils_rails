class PeerReview < ApplicationRecord
  include HashidSluggable
  extend Enumerize

  belongs_to :user
  belongs_to :space

  has_many :peer_reviews_review, class_name: "PeerReviews::Review", dependent: :destroy
  has_many :peer_reviews_participations, class_name: "PeerReviews::Participation", dependent: :destroy
  has_many :participants, through: :peer_reviews_participations, source: :user

  validates :title, presence: true

  enumerize :status, in: {
    doing: 0,
    done: 1
  }, default: :doing
end
