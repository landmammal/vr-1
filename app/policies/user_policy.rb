class UserPolicy
  # pass first the user then the model
  attr_reader :current_user, :model

  # seting up instance variables
  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  # if the current user pass is and admin allow usage of the index page
  def index?
    @current_user.admin?
  end

  def show?
    @current_user.admin? || @current_user == @user
  end

  def update?
    @current_user.admin?
  end

  def destroy?
    return false if @current_user == @user
    @current_user.admin?
  end
end
