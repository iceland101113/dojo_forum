class UsersController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @posts = Post.where("situation = ? and user_id = ?", "Publish", @user.id)
    @drafts = Post.where("situation = ? and user_id = ?", "Draft", @user.id)
    @replies = Reply.where("user_id = ?", @user.id)
    @collects = @user.collect_posts.all
  end

  def draft
    @user = current_user
    @posts = Post.where("situation = ? and user_id = ?", "Publish", @user.id)
    @drafts = Post.where("situation = ? and user_id = ?", "Draft", @user.id)
  end

  def edit
  end

  def update
    @user.update_attributes(user_params)
    redirect_to user_path(@user)
    flash[:notice] = "Your user profile was successfully updated!"
  end

  def collect
    @user = User.find(params[:user])
    @post = Post.find(params[:post_id])
    if @post.is_collected?(@user)
      @collection = Collection.where(user_id: params[:user], post_id: params[:post_id])
      @collection.destroy_all
      render :json => { :tag => "Collect", :id => 1 }
    else
      @collection = Collection.create!(user_id: params[:user], post_id: params[:post_id])   
      render :json => { :tag => "Uncollect", :id => 2 }
    end
  end

  private

  def set_user
    if  params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def user_params
    params.require(:user).permit(:name, :avatar, :description)
  end

end
