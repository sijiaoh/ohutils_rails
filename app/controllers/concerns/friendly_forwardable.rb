# From: https://github.com/heartcombo/devise/wiki/How-To:-%5BRedirect-back-to-current-page-after-sign-in,-sign-out,-sign-up,-update%5D
module FriendlyForwardable
  extend ActiveSupport::Concern

  included do
    before_action :store_user_location!, if: :storable_location?
  end

  private

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end
end
