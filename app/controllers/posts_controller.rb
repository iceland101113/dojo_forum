class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "post was successfully created"
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


end
