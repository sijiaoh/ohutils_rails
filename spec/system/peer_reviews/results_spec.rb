require "rails_helper"

RSpec.describe "peer_reviews/results", type: :system do
  let(:peer_review_user) { create :user }
  let(:peer_review) { create :peer_review, user: peer_review_user }
  let(:reviewee) { create :user }
  let!(:reviewee_participation) { create :peer_reviews_participation, peer_review:, user: reviewee }
  let!(:reviews) do
    Array.new(10).map do
      reviewer = create :user
      reviewer_participation = create(:peer_reviews_participation, peer_review:, user: reviewer)
      create :peer_reviews_review, peer_review:, reviewer_participation:, reviewee_participation:
    end
  end

  before do
    sign_in reviewee
    peer_review.update status: :done
  end

  describe "peer_reviews/results/index" do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:path) { peer_review_peer_reviews_results_path(peer_review, { user_hashid: reviewee.hashid }) }

    include_examples "simple visit test"
  end

  describe "peer_reviews/results/show" do
    it "displays result" do
      visit peer_reviews_result_path({ user_hashid: reviewee.hashid, peer_review_hashid: peer_review.hashid })

      PeerReviews::Review::SCORE_KEYS.each do |key|
        average_score = reviews.sum { |review| review.public_send(key) }.fdiv(reviews.length)
        expect(page).to have_text average_score
      end

      reviews.map(&:comment).each do |comment|
        expect(page).to have_text comment
      end
    end
  end
end
