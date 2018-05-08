class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @posts = Post.where("situation = ? and user_id = ?", "Publish", @user.id)
    @drafts = Post.where("situation = ? and user_id = ?", "Draft", @user.id)
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
