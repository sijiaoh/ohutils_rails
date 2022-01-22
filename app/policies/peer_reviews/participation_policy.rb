module PeerReviews
  class ParticipationPolicy < ApplicationPolicy
    def index?
      user&.is_admin?
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
