require "rails_helper"

RSpec.describe StudentProfile, type: :model do
  describe ".find_from_credentials" do
    let(:password) { "password" }
    let(:credentials) { exists_student_profile.slice(:student_number, :password) }
    let!(:exists_student_profile) { create :student_profile, password: }

    it "returns exists profile" do
      student_profile = described_class.find_from_credentials credentials
      expect(student_profile).to be_present
    end

    it "uses case sensitive password" do
      student_profile = described_class.find_from_credentials credentials.merge(password: password.upcase)
      expect(student_profile).to be_nil
    end
  end

  describe "#create" do
    it "generates random 6-character password" do
      student_profile = create :student_profile
      expect(student_profile.password.length).to eq 6
    end
  end
end
