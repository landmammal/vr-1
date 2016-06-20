class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :null_session

  	# al--->

	def after_sign_up_path_for(resource)
	end

	def after_sign_in_path_for(resource)
		request.env['omniauth.origin'] || stored_location_for(resource) || root_path
	end
	# al

  	private
    def user_not_authorized
      flash[:alert] = "Access denied."
      redirect_to (request.referrer || root_path)
    end

    # al--->
	protected

	def authenticate_user!
		if user_signed_in?
		  super
		else
		  redirect_to root_path
		end
	end
	# al
end
