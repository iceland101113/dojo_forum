class PostsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate_user!, only: [:new, :create, :show, :feeds]
  before_action :set_user, only: [:new, :create]

  def index
    @categories = Category.all
    if current_user == nil
      @posts = Post.publish_all.order(id: :asc).page(params[:page]).per(20)
    else
      @user = current_user

      find_friends = @user.friendships
      find_infriends = @user.inverse_friendships
      friends_id = find_friends.select(:friend_id).map(&:friend_id)
      infriends_id = find_infriends.select(:user_id).map(&:user_id)
      all_friends = friends_id + infriends_id

      @posts = Post.publish_all.or(Post.publish_myself(@user.id)).or(Post.publish_friends(all_friends)).order(id: :asc).page(params[:page]).per(20)

    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = @user.posts.build(post_params)
    @post.viewed_count = 0
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
        redirect_to user_path(@user)
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
    @reply = Reply.new
    @replies = @post.replies.includes(:user).order(created_at: :desc)
  end

  def edit
    @user = current_user
    @post = Post.find(params[:id])
  end

  def update
    @user = current_user
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
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
    flash[:alert] = "post was deleted"
  end

  def collect
    @user = User.find(params[:user])
    @post = Post.find(params[:id])
    if @post.is_collected?(@user)
      @collection = Collection.where(user_id: params[:user], post_id: params[:id])
      @collection.destroy_all
      render :json => { :tag => "Collect", :id => 1 }
    else
      @collection = Collection.create!(user_id: params[:user], post_id: params[:id])   
      render :json => { :tag => "Uncollect", :id => 2 }
    end
  end

  def feeds
    @users = User.all.size
    @posts = Post.all.size
    @comments = Reply.all.size

    @top_posts = Post.order(replies_count: :desc).limit(10)
    @top_users = User.order(replies_count: :desc).limit(10)
  end

  private

  def set_user
    if  params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

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
