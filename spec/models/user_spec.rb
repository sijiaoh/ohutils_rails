require "rails_helper"

RSpec.describe User, type: :model do
  describe "#hashid" do
    it "generates after save automatically" do
      user = create :user
      expect(user.hashid).to be_truthy
    end
  end

  describe "#terms_of_service" do
    subject(:user) { build :user }

    context "when checked" do
      it "creates user" do
        user.terms_of_service = "1"
        expect { user.save! }.to change(described_class, :count).by(1)
      end
    end

    context "when unchecked" do
      it "faileds" do
        user.terms_of_service = "0"
        expect { user.save }.to change(described_class, :count).by(0)
      end
    end
  end

  describe ".from_omniauth" do
    subject!(:user) { described_class.build_with_social_profile(params, omniauth_data).tap(&:save) }

    let(:params) { build(:user).slice(:name) }
    let(:omniauth_data) { Faker::Omniauth.google.with_indifferent_access }
    let(:access_token) { ActiveSupport::InheritableOptions.new omniauth_data }

    it "returns correct user" do
      expect(described_class.from_omniauth(access_token)).to eq user
    end
  end

  describe ".build_with_social_profile" do
    subject(:user) { described_class.build_with_social_profile(params, omniauth_data) }

    let(:params) { build(:user).slice(:name) }
    let(:omniauth_data) { Faker::Omniauth.google.with_indifferent_access }

    it "creates user and social_profile" do
      expect { user.save! }
        .to change(described_class, :count).by(1).and change(SocialProfile, :count).by(1)
    end
  end
end
