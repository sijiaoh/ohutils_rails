require "rails_helper"

RSpec.describe "Posts", type: :system do
  let(:space) { create :space }

  describe "index" do
    let(:path) { space_posts_path space }

    include_examples "simple visit test"
  end

  describe "show" do
    include_context "when signed in"

    let(:post) { create :post, user: current_user, space: }
    let(:path) { space_post_path space, post }

    include_examples "simple visit test"
  end

  describe "new" do
    include_context "when signed in"

    let(:path) { new_space_post_path space }

    include_examples "simple visit test"
  end

  describe "edit" do
    include_context "when signed in"

    let(:post) { create :post, user: current_user, space: }
    let(:path) { edit_space_post_path space, post }

    include_examples "simple visit test"
  end
end
