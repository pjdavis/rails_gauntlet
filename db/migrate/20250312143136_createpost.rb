class Createpost < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.text :body
      t.timestamps
    end
  end
end
