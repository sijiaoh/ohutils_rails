require "rails_helper"

RSpec.describe StudentProfile, type: :model do
  describe "create" do
    it "generates random 6-character password" do
      student_profile = create :student_profile
      expect(student_profile.password.length).to eq 6
    end
  end
end
