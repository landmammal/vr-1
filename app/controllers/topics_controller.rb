class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :set_course, only: [:index, :show, :new, :edit, :destroy]

  def index
    @topics = Topic.all
  end

  def show
    @lessons = @topic.lessons.order('id ASC')
    @course_registration = CourseRegistration.new
    @lesson = Lesson.new
  end

  def new
    @newTopic = Topic.new
    respond_to { |format| format.js { } }
  end

  def edit
    respond_to { |format| format.js { } }
  end

  def create
    @course = current_user.courses.find(params[:course_id])
    @course.topics.build(topic_params)

    @course.topics.last.title = 'New Topic (rename)' if @course.topics.last.title == ''

    respond_to do |format|
      if @course.save
        @topic = @course.topics.last
        @course.topics_order << @topic.refnum
        @course.save

        format.html { redirect_to course_topic_path(@course, @topic), notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    
    respond_to do |format|
      if @topic.update(topic_update)
        @topic.title = 'Unnamed Topic' if params['topic']['title'].blank?
        @topic.save
        format.html { redirect_to course_topic_path(@topic.course, @topic), notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @course.topics_order.delete(@topic.refnum)
    @course.save
    
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to course_path(@course), notice: 'Topic was successfully destroyed.' }
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
      params.require(:topic).permit(:course_id, :title, :description, :tags, :approval_status, :lessons_list, :refnum, :instructor_id)
    end
    def topic_update
      params.require(:topic).permit(:title, :description, :tags, :approval_status, :lessons_list)
    end
end
