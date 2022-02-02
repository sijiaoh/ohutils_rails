module Students
  class UsersController < ApplicationController
    skip_before_action :store_user_location!, only: %i[new]

    def index
      @student_users = authorize policy_scope([:students, User]).page(params[:page])
    end

    def new
      @student_user = User.new student_profile: StudentProfile.new
      authorize [:students, @student_user]
      skip_policy_scope
    end

    def create
      authorize %i[students user]
      skip_policy_scope
      @student_user = User.create_student student_user_params_for_create

      if @student_user.persisted?
        sign_in @student_user
        redirect_to @student_user
      else
        @error_messages = @student_user.errors.full_messages + @student_user.student_profile.errors.full_messages
        render :new, status: :unprocessable_entity
      end
    end

    private

    def student_user_params_for_create
      params.require(:user).permit(
        :name,
        :terms_of_service,
        student_profile: %i[student_number student_number_confirmation]
      )
    end
  end
end
