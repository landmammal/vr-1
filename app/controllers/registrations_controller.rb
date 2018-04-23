class RegistrationsController < Devise::RegistrationsController

  def create
    new_user = User.create(sign_up_params)    
    coupon_code = params[:user][:coupon_code]
    
    if coupon_code  && coupon_code == "emerge2018"
      new_user.approved = true
      new_user.save
      course = Course.find(3)
      course.register(new_user)
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :chat, :age, :race, :education, :email, :password, :password_confirmation, :role, :banner, :profile, :username, :terms_of_use, :auth_token)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :chat, :age, :race, :education, :email, :password, :password_confirmation, :role, :banner, :profile, :username, :terms_of_use, :current_password, :approved)
  end
end
