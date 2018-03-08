class CoursesController < ApplicationController
  before_action :authenticate_user! , except: [:index, :all, :display, :reentry]
  before_action :set_course, only: [:show, :edit, :update, :destroy, :display, :reentry, :change_topics_order]

  
  def index
    @courses = current_user.courses
  end


  def show
    @users = @course.users.order("id DESC").limit(8)
    @topics = @course.topics_order.collect {|r| Topic.find_by_refnum(r) }.compact

    remainder = @course.users.size % @users.size if @users.size > 0
    if @users.size > 0
      remainder > 0 ? @pages = ((@course.users.size - (remainder))/@users.size + 1) : @pages = @course.users.size/@users.size
    else
      @pages = 0
    end

    @topic = Topic.new
    @course_registration = CourseRegistration.new

    respond_to do |format|
      format.html {}
      format.json { render json: @course if current_user.admin? }
    end
  end


  # SEARCH FEATURE
  def search
    @courses = Course.all.map{ |x| x if ( x.privacy != 3 && x.cstatus == 1 ) }.compact
    @site_title = 'Search Courses'

    if params[:term]
      columns = %w{title short_desc tags}
      @results = Course.where( columns.map {|c| "lower(#{c}) like :term" }.join(' OR '), term: "%#{params[:term].downcase}%" )
      @courses = @results.map{ |x| x if ( x.privacy != 3 && x.cstatus == 1 ) }.compact

      respond_to do |format|
        if params[:f] == 'js'
          format.js { } 
        else
          format.html { }
        end
      end
    end

  end

  def new
    @newCourse = Course.new
    respond_to { |format| format.js { } }
  end


  def edit    
    respond_to do |format| 
      format.html{} 
      format.js{} 
    end
  end


  def create
    @new_course = current_user.courses.build(course_params)
    @new_course.price = (params[:course][:price].to_d * 100.00) if params[:course][:price] != ''
    
    respond_to do |format|
      if @new_course.save
        format.html { redirect_to @new_course, notice: 'Course was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end

  end


  def update
    
    respond_to do |format|
      if @course.update(course_update)
        @course.title = 'Unnamed Course' if @course.title.blank?
        @course.price = (params[:course][:price].to_d * 100.00) if params[:course][:price] != ''
        @course.save
        
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render json: @course }
        format.js {}
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  def destroy
    Topic.where( course_id: @course.id ).destroy_all
    @course.delete_associations
    @course.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end












  # OTHER METHODS ---------------------

  def change_topics_order
    @course.topics_order = params[:order]
    @course.save
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


  def reentry
    AdminMailer.reentry( current_user, @course ).deliver_now
    respond_to do |f|
      f.js{ }
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


  def generate_code
    new_code = "CA-"+SecureRandom.hex(n=3)
    # while Course.all.map{ |x| x.access_code }.include? ( new_code )
    #   new_code = "CA-"+SecureRandom.hex(n=3)
    # end

    puts new_code
    render json: { "new code" => new_code }.to_json
  end















  private



    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
      @site_title = 'Course:: '+@course.title
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:title, :description, :requirements, :short_desc, :color, :tags, :cstatus, :access_code, :refnum, :instructor_id, :approval_status, :cover, :cover_cache, :privacy, :language, :price, :topics_list)
    end
    def course_update
      params.require(:course).permit(:title, :description, :requirements, :short_desc, :color, :tags, :cstatus, :access_code, :approval_status, :cover, :cover_cache, :privacy, :language, :price, :topics_list)
    end
end