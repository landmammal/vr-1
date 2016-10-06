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
    case request.original_fullpath
      when '/'
        a=true
      when '/mission'
        a=true
      else
        a=false
    end

    puts a

    a && !current_user ? b=true : b=false

    return b
  end
  
end
