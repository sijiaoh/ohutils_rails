class UserPolicy < ApplicationPolicy
  def index?
    user&.is_admin?
  end

  def show?
    user&.is_admin? || user == record
  end

  def create?
    !Rails.env.production?
  end

  def update?
    user&.is_admin? || user == record
  end

  class Scope < Scope
    def resolve
      if user&.is_admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end
end
