module PeerReviews
  class ParticipationsController < ApplicationController
    before_action :set_peer_review, only: %i[index new create]
    before_action :set_peer_reviews_participation, only: %i[show edit update destroy]

    def index
      @peer_reviews_participations = policy_scope(@peer_review.peer_reviews_participations).page params[:page]
      authorize @peer_reviews_participations
    end

    def show; end

    def new
      @peer_reviews_participation = PeerReviews::Participation.new
    end

    def edit; end

    def create
      @peer_reviews_participation = PeerReviews::Participation.new(peer_reviews_participation_params)

      if @peer_reviews_participation.save
        redirect_to @peer_reviews_participation, notice: "Participation was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @peer_reviews_participation.update(peer_reviews_participation_params)
        redirect_to @peer_reviews_participation, notice: "Participation was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @peer_reviews_participation.destroy
      redirect_to peer_reviews_participations_url, notice: "Participation was successfully destroyed."
    end

    private

    def set_peer_review
      @peer_reviews_participation = policy_scope(PeerReview).find_by!(hashid: params[:peer_review_hashid])
      authorize @peer_reviews_participation, :show?
    end

    def set_peer_reviews_participation
      @peer_reviews_participation = authorize policy_scope(PeerReviews::Participation).find_by!(hashid: params[:hashid])
    end

    def peer_reviews_participation_params
      params.require(:peer_reviews_participation).permit(:user_id, :peer_review_id, :hashid, :comment)
    end
  end
end
