class CoursesController < ApplicationController
  before_action :authenticate_user! , except: [:index, :show, :all, :display, :register_with_access_code, :accept_invitation, :leave_course]
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
    user = User.find_by_email( params[:user_email] )
    @course = Course.find(params[:course_id])
    if user
      if params[:auto_add]
        registration = @course.course_registration.build( user_id: user.id, user_role: params[:user_role], approval_status: false )
        @course.save
        url = '/courses/'+@course.id.to_s+'/accept_invitation/'+user.id
      else
        url = '/courses/'+@course.id.to_s+'/accept_invitation/'
      end
      AdminMailer.invite_to_course( user, @course, url).deliver_later
    else
      AdminMailer.invite_to_website( params[:user_email], @course ).deliver_later
    end

    render json: { "message" => "sent" }.to_json
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
      course.course_registrations.build( user_id: current_user.id, user_role: params[:user_role], approval_status: true ) if !cr
      if course.save
        redirect_to course_path( course )
      end
    end

  end

  def leave_course
    course = Course.find( params[:course_id] )
    cr = course.course_registrations.find_by( user_id: params[:user_id] )
    if cr.destroy
      redirect_to user_path( params[:user_id] )
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    # get original topics created by that course
    @orig_topics = Topic.where(course_id: @course.id)
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

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @new_course = current_user.courses.build(course_params)
    @new_course.title = 'New Course (rename)' if @new_course.title == ''
    # @new_course.save
    
    respond_to do |format|
      if @new_course.save
        # format.html { redirect_to @new_course, notice: 'Course was successfully created.' }
        # format.json { render :show, status: :created, location: @course }
        format.js { }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    @course.title = 'New Course (rename)' if params[:title] = ''
    # puts '==============='
    # puts params[:title]
    
    respond_to do |format|
      if @course.update(course_update)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
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
      params.require(:course).permit(:title, :description, :tags, :cstatus, :access_code, :instructor_id, :approval_status, :privacy, :language)
    end
    def course_update
      params.require(:course).permit(:title, :description, :tags, :cstatus, :access_code, :approval_status, :privacy, :language)
    end
end
