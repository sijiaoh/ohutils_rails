module PeerReviews
  class ParticipationsController < ApplicationController
    before_action :set_peer_review, only: %i[index new create]
    before_action :set_peer_reviews_participation, only: %i[show edit update destroy]

    def index
      @self_peer_reviews_participation = self_peer_reviews_participation
      authorize @self_peer_reviews_participation if @self_peer_reviews_participation.present?
      @not_reviewed_peer_reviews_participations = not_reviewed_peer_reviews_participations.includes([:peer_review])
      authorize @not_reviewed_peer_reviews_participations
      @reviewed_peer_reviews_participations = authorize reviewed_peer_reviews_participations
    end

    def show; end

    def new
      @peer_reviews_participation = authorize PeerReviews::Participation.new(peer_review: @peer_review)
      skip_policy_scope
    end

    def edit; end

    def create
      p = peer_reviews_participation_params.merge(user: current_user, peer_review: @peer_review)
      @peer_reviews_participation = authorize PeerReviews::Participation.new(p)
      skip_policy_scope

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
      redirect_to @peer_reviews_participation.peer_review, notice: "Participation was successfully destroyed."
    end

    private

    def self_peer_reviews_participation
      @self_peer_reviews_participation ||= peer_reviews_participations.find_by user: current_user
    end

    def not_reviewed_peer_reviews_participations
      self_reviews = current_user.sended_peer_reviews_reviews.where peer_review: @peer_review
      peer_reviews_participations
        .where.not(id: self_peer_reviews_participation&.id)
        .where.not(id: self_reviews.select(:reviewee_participation_id).distinct)
    end

    def reviewed_peer_reviews_participations
      self_reviews = current_user.sended_peer_reviews_reviews.where peer_review: @peer_review
      peer_reviews_participations
        .where.not(id: self_peer_reviews_participation&.id)
        .where(id: self_reviews.select(:reviewee_participation_id).distinct)
    end

    def peer_reviews_participations
      policy_scope(@peer_review.peer_reviews_participations).includes([:user])
    end

    def set_peer_review
      @peer_review = policy_scope(PeerReview).find_by!(hashid: params[:peer_review_hashid])
      authorize @peer_review, :show?
    end

    def set_peer_reviews_participation
      @peer_reviews_participation = authorize policy_scope(PeerReviews::Participation).find_by!(hashid: params[:hashid])
    end

    def peer_reviews_participation_params
      params.require(:peer_reviews_participation).permit(:comment)
    end
  end
end
