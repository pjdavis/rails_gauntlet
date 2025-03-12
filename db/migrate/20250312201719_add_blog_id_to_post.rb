class AddBlogIdToPost < ActiveRecord::Migration[8.0]
  def change
    add_reference :posts, :blog, index: true
  end
end
