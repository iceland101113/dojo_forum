class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  before_action :set_category

  def index
    @categories = Category.all

  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "category was successfully created"
      redirect_to admin_categories_path

    else
      @categories = Category.all
      render :index
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path
      flash[:notice] = "category was sucessfully updated"
    else
      @categories = Category.all
      render :index
    end
  end

  def destroy
    @category.destroy
    flash[:alert] = "category was successfully deleted"
    redirect_to admin_categories_path
  end


  private

    def category_params
      params.require(:category).permit(:name)
    end

    def set_category
      if  params[:id]
        @category = Category.find(params[:id])
      else
        @category = Category.new
      end
    end

    def authenticate_admin
      unless current_user.admin?
        flash[:alert] = "Not allow"
        redirect_to root_path
      end
    end

end
