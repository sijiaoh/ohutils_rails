module PeerReviews
  class ReviewPolicy < ApplicationPolicy
    def index?
      user&.is_admin?
    end

    def show?
      user&.is_admin? || user == record.reviewer
    end

    def create?
      user.present?
    end

    def update?
      user&.is_admin? || user == record.reviewer
    end

    def destroy?
      user&.is_admin? || user == record.reviewer
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
