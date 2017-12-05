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
    Rails.env.development? ? starter_course = Course.all.first : starter_course = Course.find(201) 

    if !current_user.level_1 && !@courses.include?(starter_course)
      current_user.course_registrations.build(course_id: starter_course.id).save
    end
    
    if current_user.level_2
      @course = Course.new
      @topic = Topic.new
      @lesson = Lesson.new
    end

    @site_title = current_user.first_name+' '+current_user.last_name
    
    if  !current_user.level_1 && current_user.first_contact
      Rails.env.development? ? re_pa = starter_course.topics.first.lessons.first.path : re_pa = Lesson.find(485).path
      redirect_to re_pa
    end
    
    authorize @user
  end

  def change_first_contact
    user = User.find(current_user.id)
    user.first_contact = false
    user.save
    
    render json: {message: "saved"}.to_json
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

  def email_exits
    
    if params[:emails].include?(",")
      render json: { multipl: true }
    else
      email = params[:emails]
      is_there = User.all.map{|x| x.email if x.email == email }.compact.include? (email)
      render json: { found: is_there }
    end
    
  end

  private

  def secure_params
    params.require(:user).permit(:role, :username, :approved, :terms_of_use, :email)
  end
  
end
