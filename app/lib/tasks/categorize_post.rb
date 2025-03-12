# frozen_string_literal: true

module Tasks
  class CategorizePost
    attr_reader :post

    def self.categorize(posts)
      # could also call a sidekiq/solid_job worker here to put into a background job
      posts.each { |post| new(post).call }
    end

    def initialize(post)
      @post = post
    end

    def call
      return if blog.nil?

      post.blog = blog
      post.save!
    end

    private

    def blog
      case post.title
      when /Engineering/
        Blog.find_by(title: "Engineering")
      when /Marketing/
        Blog.find_by(title: "Marketing")
      else
        nil
      end
    end
  end
end
