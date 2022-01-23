module Guests
  class UsersController < ApplicationController
    def index
      @guest_users = authorize policy_scope([:guests, User]).page(params[:page])
    end

    def new
      @guest_user = User.new
      authorize [:guests, @guest_user]
      skip_policy_scope
    end

    def create
      authorize [:guests, :user]
      skip_policy_scope
      @guest_user = User.create_guest guest_user_params

      if @guest_user.persisted?
        sign_in_and_redirect @guest_user, event: :authentication
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def guest_user_params
      params.require(:user).permit(:name, :terms_of_service)
    end
  end
end
