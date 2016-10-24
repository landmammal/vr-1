class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :set_course, only: [:index, :show, :new, :edit]
  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @rehearsal = Rehearsal.new
    @lessons = @topic.lessons.order('id ASC')
    @course_registration = CourseRegistration.new
    @lesson = Lesson.new
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @course = current_user.courses.find(params[:course_id])
    @course.topics.build(topic_params)

    @course.topics.last.title = 'New Topic (rename)' if @course.topics.last.title == ''

    respond_to do |format|
      if @course.save
        @topic = @course.topics.last
        format.html { redirect_to course_topic_path(@course, @topic), notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    @topic.title = 'New Topic (rename)'

    respond_to do |format|
      if @topic.update(topic_update)
        format.html { redirect_to course_topic_path(@topic.course, @topic), notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_course
      @course = Course.find(params[:course_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
      @site_title = 'Topic:: '+@topic.title
    end

    def topic_params
      params.require(:topic).permit(:course_id, :title, :description, :tags, :approval_status, :instructor_id)
    end
    def topic_update
      params.require(:topic).permit(:title, :description, :tags, :approval_status)
    end
end
