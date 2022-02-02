require "rails_helper"

RSpec.describe "Peer reviews", type: :system do # rubocop:disable RSpec/MultipleMemoizedHelpers
  include PeerReviews::ReviewsSupport

  let(:space) { create :space }
  let(:peer_review_params) { build :peer_review }
  let(:admin) { create :user, :admin }
  let(:student1) { create :user, :student }
  let(:student2) { create :user, :student }
  let(:users) { [admin, student1, student2] }

  def user_to(label)
    reset_session!
    sign_in public_send(label)
  end

  def check_result_display_on_page(user, peer_review)
    result = PeerReviews::Result.new user, peer_review
    PeerReviews::Review::SCORE_KEYS.each do |key|
      expect(page).to have_text result.public_send(key)
    end
    result.comments.each do |comment|
      expect(page).to have_text comment
    end
  end

  def review_to_participation(peer_review, review_params)
    visit peer_review_path(peer_review)
    click_on I18n.t("peer_reviews.reviews.new.title"), match: :first

    fill_in_review_attributes(review_params)
    should_change_current_path { click_on I18n.t("helpers.submit.create") }

    PeerReviews::Review.last
  end

  it "works" do
    # 相互評価作成。
    user_to :admin
    visit space_path(space)
    click_on I18n.t("peer_reviews.new.title")

    fill_in PeerReview.human_attribute_name(:title), with: peer_review_params.title
    should_change_current_path { click_on I18n.t("helpers.submit.create") }

    expect(PeerReview.count).to eq 1
    peer_review = PeerReview.first

    # 生徒１参加。
    user_to :student1
    visit peer_review_path(peer_review)
    click_on I18n.t("peer_reviews.participations.new.title")
    expect do
      should_change_current_path { click_on I18n.t("helpers.submit.create") }
    end.to change(PeerReviews::Participation, :count).by 1

    # 生徒２参加。
    user_to :student2
    visit peer_review_path(peer_review)
    click_on I18n.t("peer_reviews.participations.new.title")
    expect do
      should_change_current_path { click_on I18n.t("helpers.submit.create") }
    end.to change(PeerReviews::Participation, :count).by 1

    # 生徒１が生徒２を評価。
    user_to :student1
    student1_review_params = build :peer_reviews_review
    review_to_participation(peer_review, student1_review_params)

    # 生徒２が生徒１を評価。
    user_to :student2
    student2_review_params = build :peer_reviews_review
    review_to_participation(peer_review, student2_review_params)

    # adminが参加。
    user_to :admin
    visit peer_review_path(peer_review)
    click_on I18n.t("peer_reviews.participations.new.title")
    expect do
      should_change_current_path { click_on I18n.t("helpers.submit.create") }
    end.to change(PeerReviews::Participation, :count).by 1

    # adminが２人を評価。
    user_to :admin
    admin_review_params = build :peer_reviews_review
    review_to_participation(peer_review, admin_review_params)
    review_to_participation(peer_review, admin_review_params)

    # 相互評価終了。
    user_to :admin
    visit peer_review_path(peer_review)
    click_on I18n.t("edit"), match: :first

    select PeerReview.status.done.text, from: PeerReview.human_attribute_name(:status)
    should_change_current_path { click_on I18n.t("helpers.submit.update") }

    expect(peer_review.reload.status).to eq :done

    # 生徒１のリザルト画面。
    user_to :student1
    visit peer_review_path(peer_review)
    check_result_display_on_page(student1, peer_review)

    # 生徒２のリザルト画面。
    user_to :student2
    visit peer_review_path(peer_review)
    check_result_display_on_page(student2, peer_review)
  end
end
