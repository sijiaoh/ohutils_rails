require "rails_helper"

RSpec.describe "peer_reviews/participations", type: :system do
  let(:peer_review_user) { create :user }
  let(:peer_review) { create :peer_review, :with_space, user: peer_review_user }
  let(:participation) { build :peer_reviews_participation, :with_space, user: current_user }

  def to_label(attribute)
    PeerReview.human_attribute_name attribute
  end

  describe "index" do
    subject(:path) { peer_review_peer_reviews_participations_path peer_review }

    include_examples "simple visit test"
  end

  describe "show" do
    subject(:path) { peer_reviews_participation_path participation }

    include_context "when signed in"

    before do
      peer_review.save!
    end

    include_examples "simple visit test"
  end

  describe "new" do
    subject(:path) { new_peer_review_peer_reviews_participation_path peer_review }

    include_context "when signed in"

    it "creates new participation" do
      visit path

      fill_in to_label(:comment), with: participation.comment

      click_on I18n.t "helpers.submit.create"
      expect(page).not_to have_current_path path

      attributes = [:user_id, :peer_review_id, :comment]
      expect(PeerReviews::Participation.first.slice(*attributes)).to eq participation.slice(*attributes)
    end
  end

  describe "edit" do
    subject(:path) { edit_peer_reviews_participation_path participation }

    let(:comment) { Faker::Lorem.paragraph }

    before do
      participation.save!
    end

    include_context "when signed in"

    it "change existing participation" do
      visit path

      fill_in to_label(:comment), with: comment

      click_on I18n.t "helpers.submit.update"
      expect(page).to have_current_path peer_review_path(participation)

      attributes = [:user_id, :peer_review_id, :comment]
      expect(
        PeerReviews::Participation.first.slice(*attributes)
      ).to eq participation.slice(*attributes).merge(comment:)
    end
  end

  describe "destroy" do
    subject(:path) { peer_reviews_participation_path participation }

    include_context "when signed in"

    before do
      participation.save!
    end

    it "destroys participation" do
      visit path

      expect do
        click_on I18n.t("destroy")
        expect(page).not_to have_current_path path
      end.to change(PeerReviews::Participation, :count).by(-1)
    end
  end
end
