class Api::V1::PostsController < ApiController
before_action :authenticate_user!, only: [:show, :destroy]

  def index
    @posts = Post.all
    render json: {
      data: @posts.map do |post|
        {
          id: post.id,
          title: post.title,
          content: post.content,
          user_id: post.user_id,
          image: post.image
         }
      end
    }
  end

  def show
    @post = Post.find(params[:id])
    render json: {
      id: @post.id,
      title: @post.title,
      content: @post.content,
      user_id: @post.user_id,
      image: @post.image
    }
  end

  def create
    @user = User.find(2)
    @post = @user.posts.build(post_params)
    @post.viewed_count = 0
    @post.category_ids = params[:category_ids]

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

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    render json: {
      message: "Photo destroy successfully!"
    }
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :authority, :image, :category_ids)
  end

end
