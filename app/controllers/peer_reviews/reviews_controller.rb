module PeerReviews
  class ReviewsController < ApplicationController
    before_action :set_peer_review, only: %i[index new create]
    before_action :set_participation, only: %i[new create]
    before_action :set_review, only: %i[show edit update destroy]

    def index
      @reviews = authorize policy_scope(Review).page params[:page]
    end

    def show; end

    def new
      @review = authorize Review.new
      skip_policy_scope
    end

    def edit; end

    def create
      @review = authorize Review.new(create_params)
      skip_policy_scope

      if @review.save
        redirect_to @review, notice: "Review was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @review.update(review_params)
        redirect_to @review, notice: "Review was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @review.destroy
      redirect_to @review.peer_review, notice: "Review was successfully destroyed."
    end

    private

    def set_peer_review
      @peer_review = policy_scope(PeerReview).find_by!(hashid: params[:peer_review_hashid])
      authorize @peer_review, :show?
    end

    def set_participation
      @participation = policy_scope(@peer_review.participations).find_by!(hashid: params[:participation_hashid])
      authorize @participation, :show?
    end

    def set_review
      @review = authorize policy_scope(Review).find_by!(hashid: params[:hashid])
    end

    def review_params
      params.require(:peer_reviews_review).permit(:like, :technical, :creativity, :composition, :growth, :comment)
    end

    def create_params
      self_participation = current_user.peer_reviews_participations.find_by!(peer_review: @peer_review)
      review_params.merge(
        peer_review: @peer_review,
        reviewer_participation: self_participation,
        reviewee_participation: @participation
      )
    end
  end
end
