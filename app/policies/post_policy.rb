class PostPolicy < ApplicationPolicy
  def index?
    return true if record.is_a? Symbol

    record.all? do |post|
      Pundit.policy(user, post).show?
    end
  end

  def show?
    record.published? || user == record.user
  end

  def create?
    user&.is_admin?
  end

  def update?
    user&.is_admin? || user == record.user
  end

  def destroy?
    user&.is_admin? || user == record.user
  end

  class Scope < Scope
    def resolve
      if user&.is_admin?
        scope.all
      else
        scope.where(published: true)
      end
    end
  end
end
