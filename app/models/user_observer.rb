class UserObserver < ActiveRecord::Observer
  #def after_create(user)
  #  puts "I am being called ------------~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  #  UserMailer.deliver_signup_notification(user)
  #end

  def after_save(user)
    UserMailer.deliver_activation(user) if user.recently_activated?
  end
end
