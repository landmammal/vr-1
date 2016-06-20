class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :age, :race, :company, :education, :email, :password, :password_confirmation, :role, :banner, :profile)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :age, :race, :company, :education, :email, :password, :password_confirmation, :role, :banner, :profile)
  end
end
