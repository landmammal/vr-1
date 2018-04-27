class RegistrationsController < Devise::RegistrationsController

  def create
    @registered = false
   
    new_user = User.new(sign_up_params)
    code = params[:user][:access_code]

    if code 
      if check_access_code(code)
        # new_user.approved = true
        if new_user.save
          Course.find_by(access_code: code).register(new_user)
          @registered = true
        end
      end
    elsif new_user.save
      @registered = true
    end

    respond_to { |format| format.js {  } }
  end

  def check_access_code(code)
    course = Course.find_by(access_code: code)
    if course 
      return true
    else
      return false
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
