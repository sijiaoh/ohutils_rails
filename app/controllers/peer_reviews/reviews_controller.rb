class PeerReviews::ReviewsController < ApplicationController
  before_action :set_peer_reviews_review, only: %i[show edit update destroy]

  # GET /peer_reviews/reviews
  def index
    @peer_reviews_reviews = PeerReviews::Review.all
  end

  # GET /peer_reviews/reviews/1
  def show; end

  # GET /peer_reviews/reviews/new
  def new
    @peer_reviews_review = PeerReviews::Review.new
  end

  # GET /peer_reviews/reviews/1/edit
  def edit; end

  # POST /peer_reviews/reviews
  def create
    @peer_reviews_review = PeerReviews::Review.new(peer_reviews_review_params)

    if @peer_reviews_review.save
      redirect_to @peer_reviews_review, notice: "Review was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /peer_reviews/reviews/1
  def update
    if @peer_reviews_review.update(peer_reviews_review_params)
      redirect_to @peer_reviews_review, notice: "Review was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /peer_reviews/reviews/1
  def destroy
    @peer_reviews_review.destroy
    redirect_to peer_reviews_reviews_url, notice: "Review was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_peer_reviews_review
    @peer_reviews_review = PeerReviews::Review.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def peer_reviews_review_params
    params.require(:peer_reviews_review).permit(:hashid, :peer_review_id, :reviewer_id, :reviewee_id, :like,
                                                :technical, :creativity, :composition, :growth, :comment)
  end
end
