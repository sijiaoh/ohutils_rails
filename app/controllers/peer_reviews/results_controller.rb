module PeerReviews
  class ResultsController < ApplicationController
    def show
      authorize %i[peer_reviews result]
      peer_review = authorize policy_scope(PeerReview).find_by! hashid: params[:peer_review_hashid]
      @result = Result.new current_user, peer_review
    end
  end
end
