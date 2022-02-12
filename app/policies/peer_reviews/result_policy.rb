module PeerReviews
  class ResultPolicy < ApplicationPolicy
    def index?
      user&.is_admin?
    end

    def show?
      user&.is_admin? || user == record.user
    end
  end
end
