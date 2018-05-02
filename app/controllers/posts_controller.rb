class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "post was successfully created"
      if published?
        @post.situation = "Publish"
        @post.save
      else
        @post.situation = "Draft"
        @post.save
      end
      redirect_to root_path
    else
      flash.now[:alert] = "post was failed to create"
      render :new
    end

  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :authority)
  end

  def published?
    params[:commit] == "Publish"
  end


end
