module PeerReviews
  class ResultsController < ApplicationController
    before_action :set_peer_review

    def index
      @users = @peer_review.participants.page params[:page]
    end

    def show
      user = authorize policy_scope(User).find_by! hashid: params[:user_hashid]
      @result = authorize Result.new user, @peer_review
    end

    private

    def set_peer_review
      @peer_review = policy_scope(PeerReview).find_by! hashid: params[:peer_review_hashid]
      authorize @peer_review, :show?
    end
  end
end
