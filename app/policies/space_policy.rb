class SpacePolicy < ApplicationPolicy
  def index?
    user&.is_admin?
  end

  def show?
    true
  end

  def create?
    user.present? && !user.is_student?
  end

  def update?
    user&.is_admin?
  end

  def destroy?
    user&.is_admin?
  end
end
