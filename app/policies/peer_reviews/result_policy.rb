module PeerReviews
  class ResultPolicy < ApplicationPolicy
    def show?
      user.present?
    end
  end
end
