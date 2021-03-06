class RepliesController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate_user!, only: [:create, :edit]
  before_action :set_reply

  def create
    @post = Post.find(params[:post_id])
    @reply = @post.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    if @reply.save
      UserConfirmEmailJob.set(wait: 5.seconds).perform_later(@post.user, @post, @reply)
      # ContactMailer.say_hello_to(@post.user, @post, @reply).deliver_now 
      flash[:notice] = "reply was successfully created"
      redirect_to post_path(@post)        
    else
      flash[:alert] = "reply was failed to create"
      render post_path(@post)
    end

  end

  def edit
    @reply = Reply.find(params[:id])
    render :json => { :id => @reply.id, :content => @reply.content, :p_id => @reply.post_id }
  end

  def update
    @reply = Reply.find(params[:id])
    @reply.update_attributes(content: params[:content])
    render :json => { :id => @reply.id, :content => @reply.content }
  end

  def destroy
    @reply.destroy
    render :json => { :id => @reply.id }
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
