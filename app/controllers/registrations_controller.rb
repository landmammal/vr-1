class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :age, :race, :education, :email, :password, :password_confirmation, :role, :banner, :profile, :username)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :age, :race, :education, :email, :password, :password_confirmation, :role, :banner, :profile, :current_password, :username, :approved)
  end
end
