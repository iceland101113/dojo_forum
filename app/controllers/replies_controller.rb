class RepliesController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_reply

  def create
    @post = Post.find(params[:post_id])
    @reply = @post.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    if @reply.save
      flash[:notice] = "reply was successfully created"
      redirect_to post_path(@post)     
    else
      flash[:alert] = "reply was failed to create"
      render post_path(@post)
    end

  end

  def update

  end

  def destroy
    @post = Post.find(params[:post_id])
    @reply.destroy
    redirect_to post_path(@post) 
  end

  private

  def reply_params
    params.require(:reply).permit(:content)
  end

  def set_reply
    if  params[:id]
      @reply = Reply.find(params[:id])
    else
      @reply = Reply.new
    end
  end

end
