class UsersController < ApplicationController
  # before_action :set_user, only: [:show]

  def show
    @user = current_user
    @posts = Post.where("situation = ? and user_id = ?", "Publish", @user.id)
  end

  def draft
    @user = User.find(params[:user])
    @posts = Post.where("situation = ? and user_id = ?", "Draft", @user.id)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
    redirect_to user_path(@user)
    flash[:notice] = "Your user profile was successfully updated!"
  end

  def set_user
    if  params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def user_params
    params.require(:user).permit(:name, :avatar)
  end

end
