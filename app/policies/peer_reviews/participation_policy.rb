module PeerReviews
  class ParticipationPolicy < ApplicationPolicy
    def index?
      user&.is_admin?
    end

    def show?
      user&.is_admin? || user == record.user
    end

    def create?
      user.present?
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
