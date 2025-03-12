# frozen_string_literal: true

RSpec.describe Tasks::CategorizePost do
  describe ".categorize" do
    it "categorizes all posts" do
      marketing_blog = Blog.create(title: "Marketing")
      engineering_blog = Blog.create(title: "Engineering")

      marketing = Post.create(title: "Marketing Post", body: "Lorem ipsum")
      engineering = Post.create(title: "Engineering Post", body: "Lorem ipsum")
      other = Post.create(title: "Other", body: "Lorem ipsum")

      posts = [marketing, engineering, other]
      Tasks::CategorizePost.categorize(posts)

      aggregate_failures("categorized") do
        expect(marketing.reload.blog).to eq(marketing_blog)
        expect(engineering.reload.blog).to eq(engineering_blog)
        expect(other.reload.blog).to be_nil
      end
    end
  end

  describe "#call" do
    context "with a post with the engineering preamble" do
      let!(:blog) { Blog.create(title: "Engineering") }
      let(:post) { Post.create(title: "Engineering - Post Title", body: "Lorem ipsum") }

      it "gets assigned to the 'Engineering' blog" do
        Tasks::CategorizePost.new(post).call
        expect(post.reload.blog).to eq(blog)
      end
    end

    context "with a post with the engineering preamble" do
      let!(:blog) { Blog.create(title: "Marketing") }
      let(:post) { Post.create(title: "Marketing - Post Title", body: "Lorem ipsum") }

      it "gets assigned to the 'Engineering' blog" do
        Tasks::CategorizePost.new(post).call
        expect(post.reload.blog).to eq(blog)
      end
    end

    context "with a post that is neither engineering nor marketing" do
      let(:post) { Post.create(title: "Other - Post Title", body: "Lorem ipsum") }

      it "is unassigned" do
        Tasks::CategorizePost.new(post).call
        expect(post.reload.blog).to be_nil
      end
    end
  end
end
