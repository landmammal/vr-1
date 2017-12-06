class CoursesController < ApplicationController
  before_action :authenticate_user! , except: [:index, :show, :all, :display]
  before_action :set_course, only: [:show, :edit, :update, :destroy, :display]
  # GET /courses
  # GET /courses.json
  def index
    @courses = current_user.courses
    @courses_api = Course.all

    if current_user.level_2
      @course = Course.new
      @new_topic = Topic.new
      @new_lesson = Lesson.new
    end
  end

  def search
    @courses = Course.all.map{ |x| x if ( x.privacy != 3 && x.cstatus == 1 ) }.compact
    @site_title = 'Search Courses'
    if current_user.level_2
      @course = Course.new
      @new_topic = Topic.new
      @new_lesson = Lesson.new
    end
  end

  def send_invite
    @course = Course.find(params[:course_id])
    @emails = params[:emails].split(',')
    @already = []
    
    @emails.each do |email|
      user = User.find_by_email( email.strip )
      if user
        if params[:auto_add]
          cr = @course.course_registrations.find_by( user_id: user.id )
          if !cr
            registration = @course.course_registrations.build( user_id: user.id, user_role: params[:user_role], approval_status: true )
            @course.save
          else
            @already << user.email
          end
          url = '/courses/'+@course.id.to_s+'/accept_invitation/'+user.id.to_s
        else
          url = '/courses/'+@course.id.to_s+'/accept_invitation/'
        end

        if @course.paid?
          url = course_path( @course )
        end
        
        @notif = "invite"
        AdminMailer.invite_to_course( user, @course, url).deliver_later
      else
        @notif = "new"
        AdminMailer.invite_to_website( email.strip, @course ).deliver_later
      end
    end
    
    respond_to do |format|
      format.js { }
    end
  end

  def accept_invitation
    # @access = false
    @course = Course.find(params[:course_id])
    @access = true
    @needs_access_code = true

    cr = @course.course_registrations.find_by( user_id: current_user.id ) 
    
    if cr
      redirect_to course_path( @course )
    end

    if params[ :user_id ] && current_user
      @access = true
      course_regist = current_user.course_registrations.find_by( course_id: params[:course_id] )
      if course_regist
        @needs_access_code = false
      else
        @needs_access_code = true
        course_regist.approval_status = true
        course_regist.save
      end
    end
  end

  def register_with_access_code
    course = Course.find(params[:course_id])
    cr = course.course_registrations.find_by( user_id: current_user.id )

    if cr
      redirect_to course_path( course )
    end

    if params[:access_code] == course.access_code
      ccr = course.course_registrations.build( user_id: current_user.id, user_role: params[:user_role], approval_status: true ) if !cr
      
      respond_to do |format|
        if course.save
          @accepted = true
        else
          @accepted = false
        end
        format.js { }
      end
    
    end

  end

  def leave_course
    course = Course.find( params[:course_id] )
    cr = course.course_registrations.find_by( user_id: current_user.id )

    if course.paid?
      cr.approval_status = false 
      cr.save!
    else
      cr.destroy
    end

    redirect_to user_path( current_user )
  end


  def activate_deactivate_student
    course = Course.find( params[:course_id] )
    cr = course.course_registrations.find_by( user_id: params[:user_id] )

    if cr
      cr.approval_status ? cr.approval_status = false : cr.approval_status = true
      cr.save!

      render json: {message: "changed"}.to_json
    end

  end



  def remove_student
    course = Course.find( params[:course_id] )
    cr = course.course_registrations.find_by( user_id: params[:user_id] )

    if cr.destroy
      render json: {message: "removed"}.to_json
    end
  end


  def student_list_nav
    @course = Course.find( params[:course_id] )
    @c = params[:current].to_i
    a = params[:amount].to_i
    @d = params[:direction]

    if @d == "next"
      @users = @course.users.limit( a ).offset( ( @c*a + a )).order("id DESC")
      @c += 1
    else
      @users = @course.users.limit( a ).offset( ( @c*a - a )).order("id DESC")
      @c -= 1
    end

    if @users.size < 1
      @users = @course.users.limit( a ).offset( 0 ).order("id DESC")
      @c = 0
    end

    respond_to do |format|
      format.js{}
    end
  end

  

  def show
    # get original topics created by that course
    @orig_topics = Topic.where(course_id: @course.id)
    @users = @course.users.order("id DESC").limit(8)

    remainder = @course.users.size % @users.size if @users.size > 0
    if @users.size > 0
      remainder > 0 ? @pages = ((@course.users.size - (remainder))/@users.size + 1) : @pages = @course.users.size/@users.size
    else
      @pages = 0
    end

    @topic = Topic.new
    @course_registration = CourseRegistration.new
  end




  def generate_code
    new_code = "CA-"+SecureRandom.hex(n=3)
    # while Course.all.map{ |x| x.access_code }.include? ( new_code )
    #   new_code = "CA-"+SecureRandom.hex(n=3)
    # end

    puts new_code
    render json: { "new code" => new_code }.to_json
  end




  def display
    if current_user
      redirect_to '/courses/'+params[:id].to_s
    end
  end

  
  

  def new
    @course = Course.new
  end

 
  

  def edit
  end


  

  def create
    @new_course = current_user.courses.build(course_params)
    @new_course.title = 'New Course (rename)' if @new_course.title == ''
    @new_course.price = (params[:course][:price].to_d * 100.00) if params[:course][:price] != ''
    # @new_course.save
    
    respond_to do |format|
      if @new_course.save
        format.html { redirect_to @new_course, notice: 'Course was successfully created.' }
        # format.json { render :show, status: :created, location: @course }
        # format.js { }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end

  end


  

  def update
    @course.title = 'New Course (rename)' if params[:course][:title] == ''
    
    # puts '==============='
    # puts params[:title]
    
    respond_to do |format|
      if @course.update(course_update)
        @course.price = (params[:course][:price].to_d * 100.00) if params[:course][:price] != ''
        @course.save
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  



  def destroy
    @course.delete_associations
    @course.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end




  private



    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
      @site_title = 'Course:: '+@course.title
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:title, :description, :tags, :cstatus, :access_code, :instructor_id, :approval_status, :privacy, :language, :price)
    end
    def course_update
      params.require(:course).permit(:title, :description, :tags, :cstatus, :access_code, :approval_status, :privacy, :language, :price)
    end
end
