class SessionsController < ApplicationController
  skip_before_action :store_user_location!, only: %i[new]

  def new
    authorize :session
    skip_policy_scope
  end

  def destroy
    authorize :session
    skip_policy_scope

    sign_out current_user
    redirect_to root_path
  end
end
