class StaticPagesController < ApplicationController
  def home
    @spaces = policy_scope(Space).where(display_on_home: true)
    skip_authorization if @spaces.blank?
    @spaces.each do |space|
      authorize space, :show?
    end
  end
end
