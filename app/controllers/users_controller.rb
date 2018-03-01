class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def  index
    if params[:approved] == "false"
      @users = User.order("first_name, last_name").where( approved: false ).where.not(id: current_user.id)
    elsif params[:role]
      @users = User.where(role: params[:role]).where.not(id: current_user.id)
    else
      @users = User.order("first_name, last_name").where.not(id: current_user.id).all
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
    ( Rails.env.development? || Rails.env.test? ) ? starter_course = Course.all.first : starter_course = Course.find(201) 

    if !current_user.level_1 && starter_course && !current_user.registered(starter_course)
      current_user.course_registrations.build(course_id: starter_course.id).save
    end

    
    @all_courses = Course.all.page( params[:page] ).reverse_order if current_user.level_1
    
    if current_user.level_2
      @new_course = Course.new
    end

    @site_title = current_user.first_name+' '+current_user.last_name
    
    if !current_user.level_1 && current_user.first_contact && starter_course
      ( Rails.env.development? || Rails.env.test? ) ? re_pa = starter_course.topics.first.lessons.first.path : re_pa = Lesson.find(485).path
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


  def batch_update
    ids = params[:list_ids].split(',')
    
    User.where(id: ids).each do |user|
      if !params[:role].blank?
        user.role = params[:role] 
        user.save
      end
      
      if !params[:approved].blank?
        if params[:approved] == 'delete'
          user.destroy
        else
          user.approved = params[:approved]
          user.save
        end
      end
    end

    redirect_back(fallback_location: request.original_url )
  end

  def transfer
    # SELF
    # user.skills
    # user.experience
    # user.facebook
    # user.twitter
    # user.linkedin
    # user.first_contact
    # user.chat

    # REHEARSER
    User.all.each do |user|
      user_data = {
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        username: user.username,
        password:'password1234',
        age: user.age,
        sex: user.gender,
        race: user.race,
        education: user.education,
        skills: nil ,
        language: user.preferred_language,
        about: nil ,
        bio: user.bio,
        photo: nil ,
        banner: nil ,
        theme: nil ,
        phone_number: user.phone_number,
        website: user.website,
        address_1: nil ,
        address_2: nil ,
        city: nil ,
        state: nil ,
        country: nil ,
        zipcode: user.zip_code,
        industry: nil ,
        category: nil ,
        privacy: nil ,
        approved: user.approved,
        role: user.role,
        auth_token: nil ,
        terms_of_use: user.terms_of_use
      }
      rehearser( param:user_data, action:'post', v:1, path:'/users', uid:false)
    end

    # Transfer

  end

  private

  def secure_params
    params.require(:user).permit(:role, :username, :approved, :chat, :terms_of_use, :email, :auth_token)
  end
  
end
