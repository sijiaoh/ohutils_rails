class Space < ApplicationRecord
  include HashidSluggable

  validates :name, presence: true

  has_many :posts, dependent: :destroy
  has_many :peer_reviews, dependent: :destroy
end
