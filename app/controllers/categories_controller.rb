class CategoriesController < ApplicationController

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    if current_user == nil
      @posts = @category.posts.publish_all.order(id: :asc).page(params[:page]).per(20)
    else
      @user = current_user
      find_friends = @user.friendships
      find_infriends = @user.inverse_friendships
      friends_id = find_friends.select(:friend_id).map(&:friend_id)
      infriends_id = find_infriends.select(:user_id).map(&:user_id)
      all_friends = friends_id + infriends_id

      c_posts = @category.posts.all

      @posts = c_posts.publish_all.or(c_posts.publish_myself(@user.id)).or(c_posts.publish_friends(all_friends)).order(id: :asc).page(params[:page]).per(20)

    end
  end

end
