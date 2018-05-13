class Api::V1::PostsController < ApiController
  def index
    @posts = Post.all
    render json: @posts
  end
end
