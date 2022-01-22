class PeerReview < ApplicationRecord
  include HashidSluggable
  extend Enumerize

  belongs_to :user
  belongs_to :space

  has_many :peer_reviews_participations, class_name: "PeerReviews::Participation", dependent: :destroy
  has_many :participants, through: :peer_reviews_participations, foreign_key: :user_id

  validates :title, presence: true

  enumerize :status, in: {
    doing: 0,
    done: 1
  }, default: :doing
end
