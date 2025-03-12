class PostsController < ApplicationController
    def index
        @posts = Post.all
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        if @post.save
          flash.now[:notice] = "Post successfully created!"
        else
          flash.now[:alert] = "Post could not be created!"
          render status: 422
        end
    end

    private

    def post_params
        params.require(:post).permit(:title, :description, :body)
    end
end
