require "rails_helper"

RSpec.describe "sign up", type: :system do
  it "sign up" do
    visit "/"
    click_on I18n.t("sign_in.index.title")
    expect(page).to have_current_path(sign_in_path)
    click_on I18n.t("sign_in.index.with_google")
    expect(page).to have_current_path(new_user_path)

    expect do
      check User.human_attribute_name(:terms_of_service)
      click_on I18n.t("helpers.submit.create")
      expect(page).not_to have_current_path(new_user_path)
    end.to change(User, :count).by(1).and change(SocialProfile, :count).by(1)

    user = User.first
    social_profile = user.social_profiles.first
    google = OmniAuth.config.mock_auth[:google_oauth2]
    expect(social_profile.provider).to eq google[:provider]
    expect(social_profile.uid).to eq google[:uid]
    expect(social_profile.email).to eq google[:info][:email]

    expect(page).to have_current_path user_path(user)
  end
end