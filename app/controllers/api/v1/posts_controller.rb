class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, only: [:show, :destroy, :create, :update]

  def index
    @posts = Post.all
    
  end

  def show
    @post = Post.find(params[:id])
    if !@post
      render json: {
        message: "Can't find the post!",
        status: 400
      }
    else
      render "api/v1/posts/show"
    end
  end

  def create
    @user = current_user
    @post = @user.posts.build(post_params)
    @post.category_ids = params[:category_id]
    @post.viewed_count = 0

    if @post.save
      render json: {
        message: "Post created successfully!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end

  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      render json: {
        message: "Post updated successfully!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    render json: {
      message: "Photo destroy successfully!"
    }
  end

  private

  def post_params
    params.permit(:title, :content, :authority, :image, :situation, :category_id)
  end

end
