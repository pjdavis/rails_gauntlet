class Post < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true

    belongs_to :blog, required: false
end
