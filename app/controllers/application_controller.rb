class ApplicationController < ActionController::Base
  include Pundit
  before_action :set_fix
  before_action :base_url

  def self.force_ssl(options = {})
    host = options.delete(:host)
    before_action(options) do

      if !request.ssl? && !Rails.env.development? && !(respond_to?(:allow_http?) && allow_http?)
        redirect_options = {:protocol => 'https://', :status => :moved_permanently}
        redirect_options.merge!(:host => host) if host
        redirect_options.merge!(:params => request.query_parameters)
        redirect_to redirect_options
      end
    end
  end

  force_ssl


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # protect_from_forgery prepend: true
  protect_from_forgery with: :null_session
  # skip_before_action :verify_authenticity_token

  before_action :main_links

  # def default_url_options(options={})
  #   { :secure => true }
  # end
  def rehearser_link
    Rails.env.production? ? 'http://www.rehearser.co' : 'http://localhost:4000'
  end

  def rehearser( param:nil, action:'get', v:1, path:, uid:true)
    version = "api/v"+v.to_s+"/"
    url = rehearser_link+'/'
    
    if uid
      hdrs = { "Authorization" => ENV["REHEARSER_APP_TOKEN"], "Accept" => "application/json", "Content-Type" => "application/x-www-form-urlencoded", "uid" => "#{current_user.auth_token}" }
    else
      hdrs = { "Authorization" => ENV["REHEARSER_APP_TOKEN"], "Accept" => "application/json", "Content-Type" => "application/x-www-form-urlencoded" }
    end


    case action
      when "post"
        response = Unirest.post url+version+path,
                    headers: hdrs,
                    parameters: param.to_h
      when "put"
        response = Unirest.put url+version+path,
                    headers: hdrs,
                    parameters: param.to_h
      when "delete"
        response = Unirest.delete url+version+path,
                    headers: hdrs,
                    parameters: param.to_h
      else
        response = Unirest.get url+version+path,
                    headers: hdrs,
                    parameters: param.to_h
    end

    response
  end

  def base_url
    if Rails.env.development?
      @base = "http://localhost:3000"
    elsif Rails.env.test?
      @base = "https://testing.videorehearser.com"
    else
      @base = "https://v1.videorehearser.com"
    end
  end

  def main_links
    @main_menu = ['contact']
    @languages = [['English','en'],['Spanish', 'sp']]
    @privacy = [['Public', 0],['Locked', 1],['Paid Members', 2],['Registered members', 3]]

    @lesson_type = [['Full Layout', 0],['Demonstration', 1],['Question/Answer', 2]]
    @video_type = [['Local', 'local'],['Image', 'image'],['Youtube', 'youtube']]

    @ziggeo_priority = [["Not Primary", ],["Primary", true]]
    @theteam = [{ name:'Carlos Vazquez', title:'M.S.Ed, M.I.T', role:'CEO/Co-Founder', link:'https://www.linkedin.com/in/juancvazquez' },
                { name:'David Kay', title:'MA', role:'Co-Founder', link:'https://www.linkedin.com/in/davidlkay' },
                { name:'Al Delcy', title:'MBA', role:'Lead FullStack Developer', link:'https://www.linkedin.com/in/aldelcy' },
                { name:'Roger Rodriguez', title:'', role:'BackEnd Developer', link:'https://www.linkedin.com/in/landmammal' },
                { name:'Alexis Mabe', title:'MA', role:'Instructional Designer' },
                { name:'Mevurah Deleon', title:'', role:'Digital Strategist', link:'https://www.linkedin.com/in/mevurah-deleon-06bb08123' }]

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
    # Course.all.each do |c|
    #   c.access_code = "CA-"+SecureRandom.hex(n=3) if c.access_code == nil
    #   c.privacy == 1 ? c.cstatus = 0 : c.cstatus = 1
    #   c.save
    # end
  end

end
