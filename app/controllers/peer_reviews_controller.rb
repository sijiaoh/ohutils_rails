class PeerReviewsController < ApplicationController
  before_action :set_peer_review, only: %i[show edit update destroy]

  def index
    @peer_reviews = PeerReview.all
  end

  def show; end

  def new
    @peer_review = PeerReview.new
  end

  def edit; end

  def create
    @peer_review = PeerReview.new(peer_review_params)

    if @peer_review.save
      redirect_to @peer_review, notice: "Peer review was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @peer_review.update(peer_review_params)
      redirect_to @peer_review, notice: "Peer review was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @peer_review.destroy
    redirect_to peer_reviews_url, notice: "Peer review was successfully destroyed."
  end

  private

  def set_peer_review
    @peer_review = PeerReview.find(params[:id])
  end

  def peer_review_params
    params.require(:peer_review).permit(:space_id, :title, :hashid)
  end
end
