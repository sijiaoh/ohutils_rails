class PeerReviewsController < ApplicationController
  before_action :set_space, only: %i[index new create]
  before_action :set_peer_review, only: %i[show edit update destroy]

  def index
    @peer_reviews = authorize policy_scope(@space.peer_reviews)
                    .order(created_at: :desc)
                    .eager_load([:user])
                    .page(params[:page])
  end

  def show; end

  def new
    @peer_review = authorize PeerReview.new space: @space
    skip_policy_scope
  end

  def edit; end

  def create
    @peer_review = authorize PeerReview.new(peer_review_params.merge(user: current_user, space: @space))
    skip_policy_scope

    if @peer_review.save
      redirect_to @peer_review, notice: notice_message(PeerReview)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @peer_review.update(peer_review_params)
      redirect_to @peer_review, notice: notice_message(PeerReview)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @peer_review.destroy
    redirect_to @peer_review.space, notice: notice_message(PeerReview)
  end

  private

  def set_space
    @space = authorize policy_scope(Space).find_by!(hashid: params[:space_hashid]), :show?
  end

  def set_peer_review
    @peer_review = authorize policy_scope(PeerReview).find_by!(hashid: params[:hashid])
  end

  def peer_review_params
    params.require(:peer_review).permit(:title, :status)
  end
end
