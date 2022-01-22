class PeerReview < ApplicationRecord
  include HashidSluggable
  extend Enumerize

  belongs_to :user
  belongs_to :space

  validates :title, presence: true

  enumerize :status, in: {
    doing: 0,
    done: 1
  }, default: :doing
end
