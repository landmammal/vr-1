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
    @courses = current_user.registered_courses.order('id DESC').map{ |x| x if (x.course_registrations.find_by(user_id: current_user.id).approval_status) }.compact
    @courses_pending = current_user.registered_courses.order('id DESC').map{ |x| x if (!x.course_registrations.find_by(user_id: current_user.id).approval_status) }.compact
    Rails.env.development? ? starter_course = Course.all.first : starter_course = Course.find(201) 

    if !current_user.level_1 && !@courses.include?(starter_course)
      current_user.course_registrations.build(course_id: starter_course.id).save
    end

    if current_user.level_1
      @all_courses_limit = Course.all.order('id DESC').limit(8)
      @all_courses = Course.all.size

      remainder = @all_courses % @all_courses_limit.size
      remainder > 0 ? @pages = ((@all_courses - (remainder))/@all_courses_limit.size + 1) : @pages = @all_courses/@all_courses_limit.size

    end
    
    if current_user.level_2
      @course = Course.new
      @topic = Topic.new
      @lesson = Lesson.new
    end

    @site_title = current_user.first_name+' '+current_user.last_name
    
    if !current_user.level_1 && current_user.first_contact
      Rails.env.development? ? re_pa = starter_course.topics.first.lessons.first.path : re_pa = Lesson.find(485).path
      redirect_to re_pa
    end
    
    authorize @user
  end



  def course_list_nav
    @c = params[:current].to_i
    a = params[:amount].to_i
    @d = params[:direction]

    if @d == "next"
      @courses = Course.all.limit( a ).offset( ( @c*a + a )).order("id DESC")
      @c += 1
    else
      @courses = Course.all.limit( a ).offset( ( @c*a - a )).order("id DESC")
      @c -= 1
    end

    if @courses.size < 1
      @courses = Course.all.limit( a ).offset( 0 ).order("id DESC")
      @c = 0
    end

    respond_to do |format|
      format.js{}
    end
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
