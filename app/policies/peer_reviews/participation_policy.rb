module PeerReviews
  class ParticipationPolicy < ApplicationPolicy
    def index?
      user&.is_admin?
    end

    def show?
      user&.is_admin? || user == record.user
    end

    def create?
      user.present? && !user.is_guest?
    end

    def update?
      user&.is_admin? || user == record.user
    end

    def destroy?
      user&.is_admin? || user == record.user
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
