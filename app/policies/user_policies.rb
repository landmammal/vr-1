class UserPolicies
  attr_reader :current_user, :model

  def initializer(current_user, model)
    @current_user = current_user
    @user = model
  end
end
