class Post < ApplicationRecord
  include HashidSluggable

  belongs_to :user
  belongs_to :space

  validates :title, presence: true

  before_save :escape_content

  private

  def escape_content
    return if markdown?

    self.content = Loofah.fragment(content).scrub!(:escape).to_s
  end
end
