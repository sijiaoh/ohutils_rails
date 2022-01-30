module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2 # rubocop:disable Metrics/AbcSize
      authorize %i[users omniauth_callbacks]
      skip_policy_scope

      user = User.from_omniauth(request.env["omniauth.auth"])

      if user&.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Google"
        sign_in_and_redirect user, event: :authentication
      else
        # Removing extra as it can overflow some session stores
        session["devise.omniauth_data"] = request.env["omniauth.auth"].except("extra")
        redirect_to sign_up_path, alert: user&.errors&.full_messages&.join("\n")
      end
    end
  end
end
