require "rails_helper"

RSpec.describe "student users", type: :system do
  describe "index" do
    subject(:path) { students_users_path }

    include_context "when signed in"

    before do
      current_user.add_role :admin
    end

    include_examples "simple visit test"
  end

  describe "sign up" do
    let(:path) { new_students_user_path }
    let(:student_profile_params) { build :student_profile }

    it "creates new user and signs in" do
      visit path

      fill_in User.human_attribute_name(:name), with: build(:user).name
      fill_in(
        StudentProfile.human_attribute_name(:student_number),
        with: student_profile_params.student_number
      )
      fill_in(
        StudentProfile.human_attribute_name(:student_number_confirmation),
        with: student_profile_params.student_number
      )
      check User.human_attribute_name(:terms_of_service)

      expect do
        click_on I18n.t("helpers.submit.create")
        expect(page).not_to have_current_path path
      end.to change(User, :count).by(1)
      expect(User.first).to be_is_student

      expect(page).to have_button I18n.t("sign_out")
    end
  end

  describe "sign out" do
    include_context "when signed in"

    before do
      current_user.add_role :student
    end

    it "signs out", js: true do
      visit root_path
      expect(page).to have_button I18n.t("sign_out")

      click_on I18n.t("sign_out")
      expect(page).not_to have_button I18n.t("sign_out")
    end
  end
end
