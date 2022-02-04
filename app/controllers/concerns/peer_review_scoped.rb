module PeerReviewScoped
  extend ActiveSupport::Concern

  private

  def redirect_to_peer_review_if_done
    redirect_to @peer_review if @peer_review.status.done?
  end

  def set_peer_review
    @peer_review = policy_scope(PeerReview).find_by!(hashid: params[:peer_review_hashid])
    authorize @peer_review, :show?
  end
end
