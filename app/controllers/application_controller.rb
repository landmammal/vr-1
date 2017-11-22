class ApplicationController < ActionController::Base
  include Pundit
  before_action :set_fix

  
  # def self.force_ssl(options = {})
  #   host = options.delete(:host)
  #   before_filter(options) do
      
  #     if !request.ssl? && !Rails.env.development? && !(respond_to?(:allow_http?) && allow_http?)
  #       redirect_options = {:protocol => 'https://', :status => :moved_permanently}
  #       redirect_options.merge!(:host => host) if host
  #       redirect_options.merge!(:params => request.query_parameters)
  #       redirect_to redirect_options
  #     end
  #   end
  # end

  # force_ssl


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
    @theteam = [{ name:'Carlos Vazquez', role:'CEO/Co-Founder', link:'https://www.linkedin.com/in/juancvazquez' },
                { name:'David Kay', role:'Co-Founder', link:'https://www.linkedin.com/in/davidlkay' },
                { name:'Al Delcy', role:'Product Manager', link:'https://www.linkedin.com/in/aldelcy' },
                { name:'Roger Rodriguez', role:'Lead Developer', link:'https://www.linkedin.com/in/landmammal' },
                { name:'Alexis Mabe', role:'Instructional Designer' },
                { name:'Mevurah Deleon', role:'Digital Strategist', link:'https://www.linkedin.com/in/mevurah-deleon-06bb08123' }]

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


  def set_fix
    Course.all.each do |c|
      c.access_code = "CA-"+SecureRandom.hex(n=3) if c.access_code == nil
      c.save
    end
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
