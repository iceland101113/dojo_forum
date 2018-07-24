class ContactMailer < ApplicationMailer
  def say_hello_to(user, post, reply)
    @user = user
    @post = post
    @reply = reply
    @reply_user = @reply.user
    mail to:@user.email, subject:"您的文章有新回覆"
  end
end
