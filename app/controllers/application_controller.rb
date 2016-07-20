class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :null_session

  	# al--->
  	before_filter :main_links

  	def main_links
  		@main_menu = ['about','markets','process','contact']

      if current_user
    		# @demos = Demo.all
    		@demos = Demo.where(completed: nil)
        @tasks = current_user.tasks

        @r = User.roles.keys
        @user_role = current_user.role.capitalize

        last_login = current_user.last_sign_in_at
        @last_signin = last_login.strftime("%m/%d/%Y at %I:%M%p")

      end
    end

	# def after_sign_up_path_for(resource)
	# end
  #
	# def after_sign_in_path_for(resource)
	# 	request.env['omniauth.origin'] || stored_location_for(resource) || root_path
	# end
	# al

  	private
    def user_not_authorized
      flash[:alert] = "Access denied."
      redirect_to (request.referrer || root_path)
    end

    # al--->
	# protected

	# def authenticate_user!
	# 	if user_signed_in?
	# 	  super
	# 	else
	# 	  redirect_to root_path
	# 	end
	# end
	# al
end
