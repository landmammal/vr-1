class UsersController < ApplicationController
  before_action :authenticate_user!
  # after_action :verify_authorized

  def index
    @users = User.all
    # you have to be and admin to access this page
    authorize User
  end

  def show

    @user = User.find(params[:id])
    @courses = current_user.registered_courses

    if current_user.level_2
      @course = Course.new
      @topic = Topic.new
      @lesson = Lesson.new
    elsif

    end
    authorize @user
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted"
  end

  def update
    @user = User.find(params[:id])
    authorize @user

    if @user.update_attributes(secure_params)
      redirect_to users_path, :success => 'User updated'
    else
      redirect_to users_path, :alert => 'Unable to update user'
    end
  end

  private

  def secure_params
    params.require(:user).permit(:role, :username)
  end
end
