require "rails_helper"

RSpec.describe PeerReviews::Review, type: :model do
  subject(:review) { create :peer_reviews_review, peer_review:, reviewer_participation:, reviewee_participation: }

  let(:reviewer) { create :user }
  let(:reviewee) { create :user }
  let(:reviewer_participation) { create :peer_reviews_participation, peer_review:, user: reviewer }
  let(:reviewee_participation) { create :peer_reviews_participation, peer_review:, user: reviewee }
  let(:peer_review) { create :peer_review, user: create(:user), space: create(:space) }

  describe "#reviewer" do
    it "equals with reviewer" do
      expect(review.reviewer).to eq reviewer
    end
  end

  describe "#reviewee" do
    it "equals with reviewee" do
      expect(review.reviewee).to eq reviewee
    end
  end
end
