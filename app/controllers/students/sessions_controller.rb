module Students
  class SessionsController < ApplicationController
    skip_before_action :store_user_location!, only: %i[new]

    def new
      authorize %i[students session]
      skip_policy_scope
      @student_profile = StudentProfile.new
    end

    def create
      authorize %i[students session]
      skip_policy_scope
      exists_student_profile = StudentProfile.find_by student_profile_params

      if exists_student_profile.present?
        sign_in_and_redirect exists_student_profile.user
      else
        @student_profile = StudentProfile.new student_profile_params
        @show_failed_to_sign_in_message = true
        render :new, status: :unprocessable_entity
      end
    end

    private

    def student_profile_params
      params.require(:student_profile).permit(:student_number)
    end
  end
end
