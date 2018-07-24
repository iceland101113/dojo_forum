class UserConfirmEmailJob < ApplicationJob
  queue_as :default

  def perform(user, post, reply)
    # Do something later
    ContactMailer.say_hello_to(user, post, reply).deliver_now
  end
end
