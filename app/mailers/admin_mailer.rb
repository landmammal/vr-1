class AdminMailer < ActionMailer::Base
  add_template_helper(EmailHelper)
  default from: 'notification@videorehearser.com'

  # sending admin mail when a new user registers
  def new_user_waiting_for_approval
    @url  = 'https://videorehearser.herokuapp.com/users/sign_in'
    mail(to: 'carlos@videorehearser.com', subject: "New User Signup")
  end

  # sending user welcoming email
  def user_register_notice(user)
    @user = user
    @url = 'https://videorehearser.herokuapp.com/users/sign_in'
    mail( to: @user.email,
          from: 'notification@videorehearser.com',
          subject: "Welcome to VR!")
  end

  # sending approval update to user
  def user_approved_notice(user)
    @user = user
    mail()
  end
end