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
        redirect_to user_path(current_user)
      else
        @post.situation = "Draft"
        @post.save
        redirect_to user_path(current_user)
      end
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
