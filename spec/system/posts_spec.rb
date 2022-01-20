require "rails_helper"

RSpec.describe "Posts", type: :system do
  let(:space) { create :space }
  let(:post) { build :post, user: current_user, space: }

  let(:title_label) { Post.human_attribute_name :title }
  let(:content_label) { Post.human_attribute_name :content }
  let(:published_label) { Post.human_attribute_name :published }

  def check_published
    if post.published
      check published_label
    else
      uncheck published_label
    end
  end

  describe "index" do
    subject(:path) { space_posts_path space }

    include_examples "simple visit test"
  end

  describe "show" do
    subject(:path) { post_path post }

    include_context "when signed in"

    before do
      post.save!
    end

    include_examples "simple visit test"
  end

  describe "new" do
    subject(:path) { new_space_post_path space }

    include_context "when signed in"

    it "creates new post" do
      visit path

      fill_in title_label, with: post.title
      fill_in content_label, with: post.content
      check_published

      click_on I18n.t "helpers.submit.create"
      expect(page).not_to have_current_path path

      attributes = [:title, :content, :published]
      expect(Post.first.slice(*attributes)).to eq post.slice(*attributes)
    end
  end

  describe "edit" do # rubocop:disable RSpec/MultipleMemoizedHelpers
    subject(:path) { edit_post_path existing_post }

    let(:existing_post) { create :post, user: current_user, space:, published: !post.published }

    include_context "when signed in"

    it "change existing post" do
      visit path

      fill_in title_label, with: post.title
      fill_in content_label, with: post.content
      check_published

      click_on I18n.t "helpers.submit.update"
      expect(page).to have_current_path post_path(existing_post)

      existing_post.reload
      attributes = [:title, :content, :published]
      expect(existing_post.slice(*attributes)).to eq post.slice(*attributes)
    end
  end

  describe "destroy" do
    let(:path) { post_path post }

    include_context "when signed in"

    before do
      post.save!
    end

    it "destroys post" do
      visit path

      expect do
        click_on I18n.t("destroy")
        expect(page).not_to have_current_path path
      end.to change(Post, :count).by(-1)
    end
  end
end
