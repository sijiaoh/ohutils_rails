module PeerReviews
  class ParticipationPolicy < ApplicationPolicy
    def index?
      true
    end

    def show?
      user.present?
    end

    def create?
      user.present?
    end

    def update?
      user&.is_admin? || user == record.user
    end

    def destroy?
      user&.is_admin?
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
