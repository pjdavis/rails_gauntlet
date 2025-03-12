# frozen_string_literal: true

RSpec.describe Blog, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :title }
  end

  describe "#posts" do
    it "returns all posts that belong to this blog" do
      blog = Blog.create(title: "My Blog")
      post = Post.create(title: "First Post", body: "Lorem ipsum", blog:)

      expect(blog.posts).to contain_exactly(post)
    end

    it "does not return posts that don't belong to this blog" do
      blog = Blog.create(title: "My Blog")
      post = Post.create(title: "First Post", body: "Lorem ipsum")

      expect(blog.posts).not_to contain_exactly(post)
    end
  end
end
