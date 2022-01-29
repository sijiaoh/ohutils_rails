class ApplicationController < ActionController::Base
  include FriendlyForwardable
  include Pundit

  after_action :verify_authorized
  after_action :verify_policy_scoped

  private

  def render_not_found
    render plain: "not_found", status: :not_found
  end

  def notice_message(model_class)
    t "application.success_to_#{action_name}", model_name: model_class.model_name.human
  end
end
