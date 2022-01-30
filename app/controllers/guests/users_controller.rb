module Guests
  class UsersController < ApplicationController
    skip_before_action :store_user_location!, only: %i[new]

    def index
      @guest_users = authorize policy_scope([:guests, User]).page(params[:page])
    end

    def new
      @guest_user = User.new guest_profile: GuestProfile.new
      authorize [:guests, @guest_user]
      skip_policy_scope
    end

    def create
      authorize %i[guests user]
      skip_policy_scope
      @guest_user = User.create_guest guest_user_params_for_create

      if @guest_user.persisted?
        sign_in_and_redirect @guest_user, event: :authentication
      else
        @error_messages = @guest_user.errors.full_messages + @guest_user.guest_profile.errors.full_messages
        render :new, status: :unprocessable_entity
      end
    end

    private

    def guest_user_params_for_create
      params.require(:user).permit(
        :name,
        :terms_of_service,
        guest_profile: %i[student_number student_number_confirmation]
      )
    end
  end
end
