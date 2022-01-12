class Space < ApplicationRecord
  validates :name, presence: true

  before_save :generate_slug

  def generate_slug
    self.slug = SecureRandom.uuid
  end
end
