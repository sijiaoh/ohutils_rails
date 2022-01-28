class User < ApplicationRecord
  include HashidSluggable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :timeoutable, :omniauthable, omniauth_providers: [:google_oauth2]
  rolify

  validates :name, presence: true
  validates :terms_of_service, acceptance: true

  has_many :social_profiles, dependent: :destroy
  has_many :posts, dependent: :destroy

  has_many :peer_reviews, dependent: :destroy
  has_many :peer_reviews_participations, class_name: "PeerReviews::Participation", dependent: :destroy
  has_many :participated_peer_reviews, through: :peer_reviews_participations, foreign_key: :peer_review_id
  has_many(
    :sended_peer_reviews_reviews,
    through: :peer_reviews_participations,
    source: :sended_reviews,
    dependent: :destroy
  )
  has_many(
    :received_peer_reviews_reviews,
    through: :peer_reviews_participations,
    source: :received_reviews,
    dependent: :destroy
  )

  def self.from_omniauth(access_token)
    social_profile = SocialProfile.find_by provider: access_token.provider, uid: access_token.uid
    social_profile&.user
  end

  def self.create_guest(user_params)
    user = User.create(user_params)
    user.add_role :guest if user.persisted?
    user
  end

  def self.build_with_social_profile(user_params, omniauth_data)
    user = User.new(user_params)
    user.social_profiles.new(
      provider: omniauth_data["provider"],
      uid: omniauth_data["uid"],
      email: omniauth_data["info"]["email"]
    )
    user
  end

  private

  def timeout_in
    return 1.year if is_guest?

    30.minutes
  end
end
