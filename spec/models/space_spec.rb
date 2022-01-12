require "rails_helper"

RSpec.describe Space, type: :model do
  it "generates slug before save" do
    space = build :space
    space.save!
    expect(space.slug).to be_truthy
  end
end
