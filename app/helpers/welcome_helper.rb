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

  def menu_welcome
    url = request.original_fullpath
    case url
      when '/'
        a=true
      when '/users/sign_up'
        a=true
      else
        a=false
    end
    
    a=true if url[0,9]=='/overview'

    a && !current_user ? b=true : b=false

    return b
  end
  
end
