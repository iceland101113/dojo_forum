class CategoriesController < ApplicationController

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    if current_user == nil
      @posts = @category.posts.where("authority = ? and situation = ?", "1", "Publish")
    else
      @user = current_user
      posts1 = @category.posts.where(authority: "1", situation: "Publish")
      posts3 = @category.posts.where(authority: "3", situation: "Publish", user_id: @user.id)
      @posts= posts1+posts3

      find_friends = @user.friendships
      find_friends.each do |friend|
          wfriend = @category.posts.where(user_id:friend.friend_id, situation: "Publish", authority: "2" )
        if friend.status == 1 
          @posts = @posts + wfriend
        end
      end  

      find_infriends = @user.inverse_friendships
      find_infriends.each do |infriend|
          winfriend = @category.posts.where(user_id:infriend.user_id, situation: "Publish", authority: "2" )
        if infriend.status == 1
          @posts = @posts + winfriend
        end
      end


    end
  end

end
