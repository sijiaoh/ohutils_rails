module PeerReviews
  class ReviewsController < ApplicationController
    before_action :set_peer_review, only: %i[index new create]
    before_action :set_peer_reviews_participation, only: %i[new create]
    before_action :set_peer_reviews_review, only: %i[show edit update destroy]

    def index
      @peer_reviews_reviews = authorize policy_scope(PeerReviews::Review).page params[:page]
    end

    def show; end

    def new
      @peer_reviews_review = authorize PeerReviews::Review.new
      skip_policy_scope
    end

    def edit; end

    def create
      @peer_reviews_review = authorize PeerReviews::Review.new(create_params)
      skip_policy_scope

      if @peer_reviews_review.save
        redirect_to @peer_reviews_review, notice: "Review was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @peer_reviews_review.update(peer_reviews_review_params)
        redirect_to @peer_reviews_review, notice: "Review was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @peer_reviews_review.destroy
      redirect_to @peer_reviews_review.peer_review, notice: "Review was successfully destroyed."
    end

    private

    def set_peer_review
      @peer_review = policy_scope(PeerReview).find_by!(hashid: params[:peer_review_hashid])
      authorize @peer_review, :show?
    end

    def set_peer_reviews_participation
      @peer_reviews_participation = policy_scope(@peer_review.peer_reviews_participations)
                                    .find_by!(hashid: params[:peer_reviews_participation_hashid])
      authorize @peer_reviews_participation, :show?
    end

    def set_peer_reviews_review
      @peer_reviews_review = authorize policy_scope(PeerReviews::Review).find_by!(hashid: params[:hashid])
    end

    def peer_reviews_review_params
      params.require(:peer_reviews_review).permit(:like, :technical, :creativity, :composition, :growth, :comment)
    end

    def create_params
      self_peer_reviews_participation = current_user.peer_reviews_participations.find_by!(peer_review: @peer_review)
      peer_reviews_review_params.merge(
        peer_review: @peer_review,
        reviewer_participation: self_peer_reviews_participation,
        reviewee_participation: @peer_reviews_participation
      )
    end
  end
end
