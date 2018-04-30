class UsersController < ApplicationController
  before_action :set_user

  def show

  end

  def set_user
    if  params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end
end
