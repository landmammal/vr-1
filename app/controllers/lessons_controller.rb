class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:new, :create]
  before_action :set_topic, only: [:new]
  before_action :set_lesson, only: [ :show, :edit, :update, :destroy]


  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = Lesson.all
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @explanation = Explanation.new
    @prompt = Prompt.new
    @model = Model.new
    @concept = Concept.new
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @topic = current_user.topics.find(params[:lesson][:topic_id])
    @topic.lessons.build(lesson_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to course_topic_path(@course, @topic), notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
      @lesson.destroy
      respond_to do |format|
        format.html { redirect_to lessons_url, notice: 'Lesson was successfully destroyed.' }
        format.json { head :no_content }
      end
  end

  private
    # set the topic you are in before you start adding lessons
    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_topic
      @topic = Topic.find(params[:topic_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:topic_id, :title, :description, :tags, :status, :instructor_id)
    end
end
