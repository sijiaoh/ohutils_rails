require "rails_helper"

RSpec.describe "guest users", type: :system do
  describe "index" do
    subject(:path) { guests_users_path }

    include_context "when signed in"

    before do
      current_user.add_role :admin
    end

    include_examples "simple visit test"
  end

  describe "sign up" do
    let(:path) { new_guests_user_path }

    it "creates new user and signs in" do
      visit path

      fill_in User.human_attribute_name(:name), with: build(:user).name
      check User.human_attribute_name(:terms_of_service)

      expect do
        click_on I18n.t("helpers.submit.create")
        expect(page).not_to have_current_path path
      end.to change(User, :count).by(1)
      expect(User.first).to be_is_guest

      expect(page).to have_button I18n.t("sign_out")
    end
  end

  describe "sign out" do
    include_context "when signed in"

    before do
      current_user.add_role :guest
    end

    it "signs out", js: true do
      visit root_path
      expect(page).to have_button I18n.t("sign_out")

      click_on I18n.t("sign_out")
      page.accept_confirm I18n.t("guests.users.sign_out_warning")

      expect(page).not_to have_button I18n.t("sign_out")
    end
  end
end
