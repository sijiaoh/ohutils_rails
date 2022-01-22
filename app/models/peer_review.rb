class PeerReview < ApplicationRecord
  include HashidSluggable

  belongs_to :user
  belongs_to :space

  validates :title, presence: true

  enum :status, {
    doing: 0,
    done: 1
  }
end
