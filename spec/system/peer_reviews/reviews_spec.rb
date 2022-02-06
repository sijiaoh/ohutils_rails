# rubocop:disable RSpec/MultipleMemoizedHelpers

require "rails_helper"

RSpec.describe "peer_reviews/reviews", type: :system do
  include PeerReviews::ReviewsSupport

  let(:peer_review_user) { create :user }
  let(:peer_review) { create :peer_review, user: peer_review_user }
  let(:reviewer) { create :user }
  let!(:reviewer_participation) { create :peer_reviews_participation, peer_review:, user: reviewer }
  let(:reviewee) { create :user }
  let!(:reviewee_participation) { create :peer_reviews_participation, peer_review:, user: reviewee }
  let(:review) { build :peer_reviews_review, peer_review:, reviewer_participation:, reviewee_participation: }

  before do
    sign_in reviewer
  end

  def to_label(attribute)
    PeerReviews::Review.human_attribute_name attribute
  end

  describe "index" do
    subject(:path) { peer_review_peer_reviews_reviews_path peer_review }

    before { reviewer.add_role :admin }

    include_examples "simple visit test"
  end

  describe "show" do
    subject(:path) { peer_reviews_review_path review }

    before { review.save! }

    include_examples "simple visit test"
  end

  describe "new" do
    subject(:path) do
      new_peer_review_peer_reviews_review_path(
        peer_review,
        { participation_hashid: reviewee_participation.hashid }
      )
    end

    it "creates new review", js: true do
      visit peer_review_path(peer_review)
      click_on I18n.t "peer_reviews.reviews.new.link"

      fill_in_review_attributes review
      should_change_current_path { click_on I18n.t "helpers.submit.create" }

      attributes = [*PeerReviews::Review::SCORE_KEYS, :comment]
      expect(PeerReviews::Review.first.slice(*attributes)).to eq review.slice(*attributes)
    end
  end

  describe "edit" do
    subject(:path) { edit_peer_reviews_review_path review }

    let(:review_params) { build :peer_reviews_review }

    before do
      review.save!
    end

    it "change existing review" do
      visit path

      fill_in_review_attributes review_params
      should_change_current_path { click_on I18n.t "helpers.submit.update" }

      attributes = [*PeerReviews::Review::SCORE_KEYS, :comment]
      expect(
        PeerReviews::Review.first.slice(*attributes)
      ).to eq review_params.slice(*attributes)
    end
  end

  describe "destroy" do
    subject(:path) { peer_reviews_review_path review }

    before do
      review.save!
    end

    it "destroys review", js: true do
      visit path

      expect do
        click_on I18n.t("destroy")
        page.accept_confirm I18n.t("destroy_confirm")
        expect(page).not_to have_current_path path
      end.to change(PeerReviews::Review, :count).by(-1)
    end
  end
end

# rubocop:enable RSpec/MultipleMemoizedHelpers
