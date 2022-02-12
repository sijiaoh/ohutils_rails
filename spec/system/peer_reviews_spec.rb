require "rails_helper"

RSpec.describe "Peer reviews", type: :system do
  let(:space) { create :space }
  let(:peer_review) { build :peer_review, user: current_user, space: }
  let(:current_user) { create :user, :admin }

  def to_label(attribute)
    PeerReview.human_attribute_name attribute
  end

  before do
    sign_in current_user
  end

  describe "index" do
    subject(:path) { space_peer_reviews_path space }

    include_examples "simple visit test"
  end

  describe "show" do
    subject(:path) { peer_review_path peer_review }

    before do
      peer_review.save!
    end

    include_examples "simple visit test"
  end

  describe "new" do
    subject(:path) { new_space_peer_review_path space }

    it "creates new peer review" do
      visit path

      fill_in to_label(:title), with: peer_review.title
      select peer_review.status.text, from: to_label(:status)

      click_on I18n.t "helpers.submit.create"
      expect(page).not_to have_current_path path

      attributes = %i[title status]
      expect(PeerReview.first.slice(*attributes)).to eq peer_review.slice(*attributes)
    end
  end

  describe "edit" do
    subject(:path) { edit_peer_review_path existing_peer_review }

    let(:existing_peer_review) { create :peer_review, user: current_user, space: }

    it "change existing peer review" do
      visit path

      fill_in to_label(:title), with: peer_review.title
      select peer_review.status.text, from: to_label(:status)

      click_on I18n.t "helpers.submit.update"
      expect(page).to have_current_path peer_review_path(existing_peer_review)

      existing_peer_review.reload
      attributes = %i[title status]
      expect(existing_peer_review.slice(*attributes)).to eq peer_review.slice(*attributes)
    end
  end

  describe "destroy" do
    let(:path) { peer_review_path peer_review }

    before do
      peer_review.save!
    end

    it "destroys peer review", js: true do
      visit path

      expect do
        click_on I18n.t("destroy")
        page.accept_confirm I18n.t("destroy_confirm")
        expect(page).not_to have_current_path path
      end.to change(PeerReview, :count).by(-1)
    end
  end
end
