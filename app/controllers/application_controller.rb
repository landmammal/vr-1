class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :null_session

	before_action :main_links

  def default_url_options(options={})
    { :secure => true }
  end 

	def main_links
		@main_menu = ['overview','contact']
    @languages = [['English','en'],['Spanish', 'sp']]
    @privacy = [['Public', 0],['Locked', 1],['Paid Members', 2],['Registered members', 3]]

    @lesson_type = [['Full Layout', 0],['Demonstration', 1],['Question/Answer', 2]]
    @video_type = [['Local', 'local'],['Image', 'image'],['Youtube', 'youtube']]

    @ziggeo_priority = [["Not Primary", ],["Primary", true]]
    @theteam = [{ name:'Carlos Vazquez', role:'CEO/Co-Founder' },
                { name:'David Kay', role:'Co-Founder' },
                { name:'Al Delcy', role:'Product Manager' },
                { name:'Roger Rodriguez', role:'Lead Developer' },
                { name:'Alexis Mabe', role:'Instructional Designer' },
                { name:'Mevurah Deleon', role:'Digital Strategist' }]

    if current_user
  		# @demos = Demo.all
  		@demos = Demo.where(completed: nil)
      @tasks = current_user.tasks

      @r = User.roles.keys
      @user_role = current_user.role.capitalize

      @last_signin = current_user.last_sign_in_at.strftime("%m/%d/%Y at %I:%M%p")
    end
  end

	# def after_sign_up_path_for(resource)
	# end

	def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || user_path(current_user)
	end

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
