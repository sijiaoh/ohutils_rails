require "rails_helper"

RSpec.describe Post, type: :model do
  it "escapes content before save" do
    content = "<script>alert('hi');</script>"
    post = create :post, :with_space, { user: create(:user), content: }
    expect(post.content).to eq "&lt;script&gt;alert('hi');&lt;/script&gt;"
  end
end
