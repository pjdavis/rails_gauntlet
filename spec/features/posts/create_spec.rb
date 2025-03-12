# frozen_string_literal: true

RSpec.describe "Create Post", type: :feature do
  scenario "create a new post with valid inputs" do
    visit posts_path
    fill_in "Title", with: "Test Title"
    fill_in "Body", with: "Test Body"
    click_on "Submit"

    expect(page).to have_text("Test Title")
  end

  scenario "Create a new post with missing title" do
    visit posts_path
    fill_in "Body", with: "Test Body"
    click_on "Submit"

    expect(page).to have_text("Post could not be created!")
  end
end
