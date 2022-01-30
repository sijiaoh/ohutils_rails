require "rails_helper"

RSpec.describe "student sessions", type: :system do
  subject(:path) { students_sign_in_path }

  let(:user) { create :user }
  let(:student_profile) { create :student_profile, user: }

  before do
    user.add_role :student
  end

  it "signs in" do
    visit path

    fill_in(
      StudentProfile.human_attribute_name(:student_number),
      with: student_profile.student_number
    )
    click_on I18n.t("students.sessions.new.sign_in")

    expect(page).not_to have_current_path path
    expect(page).to have_button I18n.t("sign_out")
  end
end
