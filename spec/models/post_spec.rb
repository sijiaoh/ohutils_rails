require "rails_helper"

RSpec.describe Post, type: :model do
  it "escapes content before save" do
    content = "<script>alert('hi');</script>"
    post = create :post, :with_space, { user: create(:user), content: }
    expect(post.content).to eq "&lt;script&gt;alert('hi');&lt;/script&gt;"
  end

  it "does not escape content before save if markdown" do
    content = "<script>alert('hi');</script>"
    post = create :post, :with_space, { user: create(:user), content:, markdown: true }
    expect(post.content).to eq content
  end
end
