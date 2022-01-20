class Space < ApplicationRecord
  include HashidSluggable

  validates :name, presence: true

  has_many :posts, dependent: :destroy
end
