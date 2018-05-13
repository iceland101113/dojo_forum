class UsersController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_user, only: [:show, :edit, :update]

  def show

    if @user == current_user
      @posts = Post.where("situation = ? and user_id = ?", "Publish", @user.id)
    elsif @user.is_friend?(current_user) 
      friendship = Friendship.where(user_id:@user.id, friend_id:current_user.id).last
      if friendship.status == 1
        @posts = Post.where(situation:"Publish", user_id: @user.id, authority: ["1","2"])
      else
        @posts = Post.where("situation = ? and user_id = ? and authority = ?", "Publish", @user.id, "1")
      end
    elsif current_user.is_friend?(@user)
      friendship = Friendship.where(user_id:current_user.id, friend_id:@user.id).last
      if friendship.status == 1
        @posts = Post.where(situation:"Publish", user_id: @user.id, authority:["1","2"])
      else
        @posts = Post.where("situation = ? and user_id = ? and authority = ?", "Publish", @user.id, "1")
      end
    else
      @posts = Post.where("situation = ? and user_id = ? and authority = ?", "Publish", @user.id, "1")
    end    



    @drafts = Post.where("situation = ? and user_id = ?", "Draft", @user.id)
    @replies = Reply.where("user_id = ?", @user.id)
    @collects = @user.collect_posts.all
    u = Friendship.where("user_id = ? and friend_id = ?", @user.id, current_user.id)
    f = Friendship.where("user_id = ? and friend_id = ?", current_user.id, @user.id)
    
    if u != []
      @status_u = u.last.status
    else
      @status_u = []
    end

    if f != []
      @status_f = f.last.status
    else
      @status_f = []
    end

    
    find_friends = @user.friendships
    @friends = []
    @nfriends = []
    find_friends.each do |friend|
        wfriend = User.find(friend.friend_id)
      if friend.status == 1 
        @friends[@friends.size] = wfriend
      else
        @nfriends[@nfriends.size] = wfriend
      end
    end

    

    find_infriends = @user.inverse_friendships
    @rfriends = []
    find_infriends.each do |infriend|
        winfriend = User.find(infriend.user_id)
      if infriend.status == 1
        @friends[@friends.size] = winfriend
      elsif infriend.status == nil
        @rfriends[@rfriends.size] = winfriend
      else
      end
    end

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

  def friend
    @tag = params[:tag]
    if @tag == "Add Friend"
      @in_friend = Friendship.where(user_id: params[:user], friend_id: params[:id])
      if @in_friend != []
        @in_friend.destroy
      end
      @friends = Friendship.create!(user_id: params[:user], friend_id: params[:id]) 
      render :json => { :tag => "Waiting", :id => 1 }
    else
      @friends = Friendship.where(user_id: params[:user], friend_id: params[:id])
      @friends.destroy_all     
      render :json => { :tag => "Add friend", :id => 2 }
    end

  end

  def accept
    friendship = Friendship.where(user_id:params[:friend], friend_id:params[:user]).last
    friendship.status = 1
    friendship.save
    friend = User.find(params[:friend])
    render :json => { :f_id => params[:friend], :avatar => friend.avatar, :name => friend.name }
  end

  def ignore
    friendship = Friendship.where(user_id:params[:friend], friend_id:params[:user]).last
    friendship.status = 0
    friendship.save
    friend = User.find(params[:friend])
    render :json => { :f_id => params[:friend], :avatar => friend.avatar, :name => friend.name }
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
