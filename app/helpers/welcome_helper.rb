module WelcomeHelper
#   def resource_name
#     :user
#   end
#
#   def resource
#     # @resource ||= User.new
#   end
#
#   def devise_mapping
#       @devise_mapping ||= Devise.mappings[:user]
#   end

  def home
    url = request.original_fullpath
    case url
      when '/'
        a=true
      when '/?secure=true'
        a=true
      else
        a=false
    end
    
    a=true if url[0,9]=='/overview'
    a=true if url[0,14]=='/users/sign_up'

    a && !current_user ? b=true : b=false

    return b
  end

  def in_app
    user_signed_in?
  end
  
end
