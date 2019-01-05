class Admin::UsersController < ApplicationController
  layout "backend"
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @users = User.page(params[:page]).per(20)
    @roles= Role.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update(role_params)
      @user.save
      redirect_to admin_users_path
      flash[:notice] = "role was successfully updated"
    else
      render :index
      flash[:alert] = "role was failed to update"
    end
  end

  private

  def role_params
    params.require(:user).permit(:role_id)
  end

  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not allow"
      redirect_to root_path
      end
  end

end
