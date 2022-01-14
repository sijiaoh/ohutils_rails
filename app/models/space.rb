class Space < ApplicationRecord
  validates :name, presence: true

  before_save :generate_slug

  has_many :posts, dependent: :destroy

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = SecureRandom.uuid
  end
end
