module PeerReviews
  class ParticipationsController < ApplicationController
    before_action :set_peer_reviews_participation, only: %i[show edit update destroy]

    # GET /peer_reviews/participations
    def index
      @peer_reviews_participations = PeerReviews::Participation.all
    end

    # GET /peer_reviews/participations/1
    def show; end

    # GET /peer_reviews/participations/new
    def new
      @peer_reviews_participation = PeerReviews::Participation.new
    end

    # GET /peer_reviews/participations/1/edit
    def edit; end

    # POST /peer_reviews/participations
    def create
      @peer_reviews_participation = PeerReviews::Participation.new(peer_reviews_participation_params)

      if @peer_reviews_participation.save
        redirect_to @peer_reviews_participation, notice: "Participation was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /peer_reviews/participations/1
    def update
      if @peer_reviews_participation.update(peer_reviews_participation_params)
        redirect_to @peer_reviews_participation, notice: "Participation was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /peer_reviews/participations/1
    def destroy
      @peer_reviews_participation.destroy
      redirect_to peer_reviews_participations_url, notice: "Participation was successfully destroyed."
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_peer_reviews_participation
      @peer_reviews_participation = PeerReviews::Participation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def peer_reviews_participation_params
      params.require(:peer_reviews_participation).permit(:user_id, :peer_review_id, :hashid, :comment)
    end
  end
end
