class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user! , except: [:index, :show, :all]
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  # GET /courses
  # GET /courses.json
  def index
    @courses = current_user.courses

    if current_user.level_2
      @course = Course.new
      @new_topic = Topic.new
      @new_lesson = Lesson.new
    end
  end

  def search
    @courses = Course.where.not(privacy:'1').order('id DESC')

    if current_user.level_2
      @course = Course.new
      @new_topic = Topic.new
      @new_lesson = Lesson.new
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
    @course = current_user.courses.build(course_params)

    # ===== WHEN USING JS
    # if @course.save
    #   render json: @course
    # end
    # ===== WHEN USING RUBY

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:title, :description, :tags, :instructor_id, :approval_status, :privacy, :language)
    end
    def course_update
      params.require(:course).permit(:title, :description, :tags, :approval_status, :privacy, :language)
    end
    def course_params_js
      params.permit(:title, :description, :tags, :instructor_id, :approval_status, :privacy, :language)
    end
end
