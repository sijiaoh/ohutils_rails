module Authorizable
  extend ActiveSupport::Concern

  include Pundit

  included do
    after_action :verify_authorized
    after_action :verify_policy_scoped

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  private

  def user_not_authorized
    if current_user.present?
      render_forbidden
    else
      flash[:alert] = I18n.t("devise.failure.unauthenticated")
      redirect_to sign_in_path
    end
  end
end
