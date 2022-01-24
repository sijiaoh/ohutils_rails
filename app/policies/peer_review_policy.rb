class PeerReviewPolicy < ApplicationPolicy
  def index?
    return true if record.is_a? Symbol

    record.all? do |peer_review|
      Pundit.policy(user, peer_review).show?
    end
  end

  def show?
    true
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
