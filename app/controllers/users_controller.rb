class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def  index
    if params[:approved] == "false"
      @users = User.where( approved: false )
    else
      @users = User.all
    end
    @site_title = 'All Users'
    # you have to be and admin to access this page
    authorize User
  end

  def show
    @group = Group.new
    @user = User.find(params[:id])
    @courses = current_user.registered_courses.order('id DESC')

    if current_user.level_2
      @course = Course.new
      @topic = Topic.new
      @lesson = Lesson.new
    end
    @site_title = current_user.first_name+' '+current_user.last_name

    authorize @user
  end

  def edit
    @user = User.find(params[:id])
    @site_title = 'Edit Settings'
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
    params.require(:user).permit(:role, :username, :approved, :terms_of_use, :email)
  end
  
end
