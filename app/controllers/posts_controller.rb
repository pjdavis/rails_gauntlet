class PostsController < ApplicationController
  def index
    @posts = Post.includes(:blog).all
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: "Post was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Post was successfully created." }
      else
        flash.now[:alert] = "Post could not be created!"
        format.html do
          @posts = Post.all
          render :index, status: :unprocessable_entity
        end
        format.turbo_stream { render status: :unprocessable_entity }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :body)
  end
end
