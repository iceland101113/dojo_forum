class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    if current_user == nil
      @posts = Post.where("authority = ? and situation = ?", "1", "Publish")
    else
      @user = current_user
      @posts = Post.where("authority = ? and situation = ?", "1", "Publish") + Post.where("authority = ? and user_id = ? and situation = ?", "3", @user.id, "Publish")
    end
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.build(post_params)
    @category = params[:posts][:category_ids]
    @post.category_ids = @category

    if @post.save
      flash[:notice] = "post was successfully created"
      if published?
        @post.situation = "Publish"
        @post.save
        redirect_to user_path(@user)
      else
        @post.situation = "Draft"
        @post.save
        redirect_to draft_path
      end
    else
      flash.now[:alert] = "post was failed to create"
      render :new
    end

  end

  def show
    @post = Post.find(params[:id])
    @post.viewed_count = @post.viewed_count + 1
    @post.save
    @user = User.find(@post.user_id)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @category = params[:posts][:category_ids]
    @post.category_ids = @category
    if @post.update(post_params)
      if published?
        @post.situation = "Publish"       
      elsif draft?
        @post.situation = "Draft"     
      else

      end
      @post.save
      redirect_to post_path(@post)
      flash[:notice] = "post was successfully updated"
    else
      render :edit
      flash[:alert] = "post was failed to update"
    end
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(@user)
    flash[:alert] = "post was deleted"
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :authority, :image)
  end

  def published?
    params[:commit] == "Publish"
  end

  def draft?
    params[:commit] == "Draft"
  end



end
