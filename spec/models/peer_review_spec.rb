require "rails_helper"

RSpec.describe PeerReview, type: :model do
  subject(:peer_review) { create :peer_review, space:, user: }

  let(:user) { create :user }
  let(:space) { create :space }

  describe "#destroy" do
    context "when reviewed" do
      let(:review) do
        reviewer = create :user
        reviewer_participation = create(:peer_reviews_participation, user: reviewer, peer_review:)
        reviewee = create :user
        reviewee_participation = create(:peer_reviews_participation, user: reviewee, peer_review:)
        create(:peer_reviews_review, reviewer_participation:, reviewee_participation:, peer_review:)
      end

      it "removes record" do
        review
        expect(peer_review.destroy).to be_truthy
      end
    end
  end
end
