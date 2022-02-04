module SpaceScoped
  extend ActiveSupport::Concern

  private

  def set_space
    @space = authorize policy_scope(Space).find_by!(hashid: params[:space_hashid]), :show?
  end
end
