# frozen_string_literal: true

RSpec.describe "Index posts", type: :feature do
  scenario "shows all posts" do
    Post.create(title: "First Post", body: "Lorem ipsum")
    visit posts_path

    expect(page).to have_content("First Post")
  end

  scenario "when a post belongs to a blog, display the blog name with the post" do
    blog = Blog.create(title: "Engineering")
    Post.create(title: "First Post", body: "Lorem ipsum", blog:)
    visit posts_path

    expect(page).to have_content("Engineering")
  end

  scenario "when a post does not belong to a blog, display 'No Blog'" do
    Post.create(title: "First Post", body: "Lorem ipsum")
    visit posts_path

    expect(page).to have_content("No Blog")
  end
end
