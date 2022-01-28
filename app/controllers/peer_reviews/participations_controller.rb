module PeerReviews
  class ParticipationsController < ApplicationController
    before_action :set_peer_review, only: %i[index new create]
    before_action :set_participation, only: %i[show edit update destroy]

    def index
      @self_participation = self_participation
      authorize @self_participation if @self_participation.present?
      @not_reviewed_participations = not_reviewed_participations.includes([:peer_review])
      authorize @not_reviewed_participations
      @reviewed_participations = authorize reviewed_participations
    end

    def show; end

    def new
      @participation = authorize Participation.new(peer_review: @peer_review)
      skip_policy_scope
    end

    def edit; end

    def create
      p = participation_params.merge(user: current_user, peer_review: @peer_review)
      @participation = authorize Participation.new(p)
      skip_policy_scope

      if @participation.save
        redirect_to @participation, notice: "Participation was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @participation.update(participation_params)
        redirect_to @participation, notice: "Participation was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @participation.destroy
      redirect_to @participation.peer_review, notice: "Participation was successfully destroyed."
    end

    private

    def self_participation
      @self_participation ||= participations.find_by user: current_user
    end

    def not_reviewed_participations
      self_reviews = current_user.sended_peer_reviews_reviews.where peer_review: @peer_review
      participations
        .where.not(id: self_participation&.id)
        .where.not(id: self_reviews.select(:reviewee_participation_id).distinct)
    end

    def reviewed_participations
      self_reviews = current_user.sended_peer_reviews_reviews.where peer_review: @peer_review
      participations
        .where.not(id: self_participation&.id)
        .where(id: self_reviews.select(:reviewee_participation_id).distinct)
    end

    def participations
      policy_scope(@peer_review.participations).includes([:user])
    end

    def set_peer_review
      @peer_review = policy_scope(PeerReview).find_by!(hashid: params[:peer_review_hashid])
      authorize @peer_review, :show?
    end

    def set_participation
      @participation = authorize policy_scope(Participation).find_by!(hashid: params[:hashid])
    end

    def participation_params
      params.require(:peer_reviews_participation).permit(:comment)
    end
  end
end
