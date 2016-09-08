class AdminMailer < ActionMailer::Base
  default from: 'notification@videorehearser.com'

  def new_user_waiting_for_approval
    # @user = admin
    @url  = 'http://videorehearser.com/login'
    mail(to: 'carlos@videorehearser.com', subject: "New User Signup")
  end
end