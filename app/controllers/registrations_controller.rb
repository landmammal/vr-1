class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :chat, :age, :race, :education, :email, :password, :password_confirmation, :role, :banner, :profile, :username, :terms_of_use)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :chat, :age, :race, :education, :email, :password, :password_confirmation, :role, :banner, :profile, :username, :terms_of_use, :current_password, :approved)
  end
end
