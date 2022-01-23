require "rails_helper"

RSpec.describe "authentication", type: :system do
  describe "sign up" do
    it "creates new user and signs in" do
      visit "/"
      click_on I18n.t("session.new.title")
      expect(page).to have_current_path sign_in_path
      click_on I18n.t("session.new.with_google")
      expect(page).to have_current_path sign_up_path

      fill_in User.human_attribute_name(:name), with: build(:user).name
      check User.human_attribute_name(:terms_of_service)

      expect do
        click_on I18n.t("helpers.submit.create")
        expect(page).not_to have_current_path sign_up_path
      end.to change(User, :count).by(1).and change(SocialProfile, :count).by(1)

      user = User.first
      social_profile = user.social_profiles.first
      google = OmniAuth.config.mock_auth[:google_oauth2]
      expect(social_profile.provider).to eq google[:provider]
      expect(social_profile.uid).to eq google[:uid]
      expect(social_profile.email).to eq google[:info][:email]

      expect(page).to have_button I18n.t("sign_out")
    end
  end

  describe "sign in" do
    it "signs in" do
      google = OmniAuth.config.mock_auth[:google_oauth2]
      user = User.build_with_social_profile(build(:user).slice(:name), google)
      user.save!

      visit sign_in_path
      click_on I18n.t("session.new.with_google")
      expect(page).to have_current_path root_path
      expect(page).to have_button I18n.t("sign_out")
    end
  end

  describe "sign out" do
    include_context "when signed in"

    it "signs out" do
      visit root_path
      expect(page).to have_button I18n.t("sign_out")

      click_on I18n.t("sign_out")
      expect(page).not_to have_button I18n.t("sign_out")
    end
  end
end
