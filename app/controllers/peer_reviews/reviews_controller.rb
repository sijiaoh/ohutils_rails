module PeerReviews
  class ReviewsController < ApplicationController
    include PeerReviewScoped

    before_action :set_peer_review, only: %i[index new create]
    before_action :set_review_and_peer_review, only: %i[show edit update destroy]
    before_action :redirect_to_peer_review_if_done
    before_action :set_participation, only: %i[new create]

    def index
      @reviews = authorize policy_scope(Review).page params[:page]
    end

    def show; end

    def new
      @review = authorize Review.new
      @review.reviewee_participation = @participation
      skip_policy_scope
    end

    def edit; end

    def create
      @review = authorize Review.new(create_params)
      skip_policy_scope

      if @review.save
        redirect_to @review, notice: notice_message(Review)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @review.update(review_params)
        redirect_to @review, notice: notice_message(Review)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @review.destroy
      redirect_to @review.peer_review, notice: notice_message(Review)
    end

    private

    def set_participation
      @participation = policy_scope(@peer_review.participations).find_by!(hashid: params[:participation_hashid])
      authorize @participation, :show?
    end

    def set_review_and_peer_review
      @review = authorize policy_scope(Review).find_by!(hashid: params[:hashid])
      @peer_review = @review.peer_review
    end

    def review_params
      params.require(:peer_reviews_review).permit(:fun, :technical, :creativity, :composition, :growth, :comment)
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
