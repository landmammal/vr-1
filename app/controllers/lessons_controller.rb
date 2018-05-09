class LessonsController < ApplicationController
  include TopicsHelper
  before_action :authenticate_user!
  before_action :set_course, only: [:show, :new, :create, :edit, :destroy]
  before_action :set_topic, only: [:show, :create, :new, :edit, :destroy]
  before_action :set_lesson, only: [ :show, :edit, :update, :destroy]


  # GET /lessons
  # GET /lessons.json
  def index
    if params[:topic_id]
      lessons = Lesson.where( topic_id: params[:topic_id] )
    else
      lessons = Lesson.all
    end

    respond_to do |format| 
      format.html { }
      format.js { }
      format.json { render json: lessons }
    end
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @explanation = Explanation.new
    @explanations = @lesson.explanations.select(:id, :title, :position_prior, :privacy, :video_token).order('id ASC')
    @prior_expl = @lesson.explanations.find_by(position_prior: '1')

    @prompt = Prompt.new
    @prompts = @lesson.prompts.select(:id, :title, :position_prior, :privacy, :video_token).order('id ASC')
    @prior_prompt = @lesson.prompts.find_by(position_prior: '1')

    @model = Model.new
    @models = @lesson.models.select(:id, :title, :position_prior, :privacy, :video_token).order('id ASC')
    @prior_model = @lesson.models.find_by(position_prior: '1')

    @topic_lessons = {}
    
    @lesson.topic.lessons_order.each do |l|
      lesson = Lesson.find_by_refnum(l)
      
      if topic_lesson_status(lesson)
        @topic_lessons[lesson.id] = lesson.completion_status(current_user)
      elsif lesson.instructor == current_user
        @topic_lessons[lesson.id] = ["new", "Incomplete lesson"]
      end
      
    end


    

    if (@lesson.lesson_type.to_i == 0 || @lesson.lesson_type == nil) && @prior_expl && @prior_prompt && @prior_model
      @lesson_ready = true, @all_prt = true 
    elsif @lesson.lesson_type.to_i == 1 && @prior_expl && @prior_model 
      @lesson_ready = true, @mdl_prt = true  
    elsif @lesson.lesson_type.to_i == 2 && @prior_expl && @prior_prompt
      @lesson_ready = true, @prmt_prt = true  
    end

    @concept = Concept.new
    @rehearsal = Rehearsal.new

    @lessons_arr = []
    @lessons = @topic.lessons
    @lessons.each { |lesson| @lessons_arr << lesson.id }

  end

  def new
    @lesson = Lesson.new
    respond_to { |format| format.js {  } }
  end

  def edit
    respond_to do |format|
      format.js {  }
    end
  end


  def create
    @lesson = @topic.lessons.build(lesson_params)
    
    respond_to do |format|
      if @lesson.save
        format.js   { }
        format.html { redirect_to course_topic_lesson_path(@course, @topic, @lesson), notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @lesson.update(lesson_update)
        format.js   { }
        format.html { redirect_to course_topic_lesson_path(@lesson.topic.course, @lesson.topic, @lesson), notice: 'Lesson was updated created.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @topic.lessons_order.delete(@lesson.refnum)
    @topic.save
    
    LessonRehearsal.where(lesson_id: @lesson).destroy_all
    Rehearsal.where(lesson_id: @lesson).destroy_all
    LessonExplanation.where(lesson_id: @lesson).destroy_all
    Explanation.where(lesson_id: @lesson).destroy_all
    LessonPrompt.where(lesson_id: @lesson).destroy_all
    Prompt.where(lesson_id: @lesson).destroy_all
    LessonModel.where(lesson_id: @lesson).destroy_all
    Model.where(lesson_id: @lesson).destroy_all

    if @lesson.destroy
      respond_to do |format|
        format.html { redirect_to course_topic_path(@course, @topic), notice: 'Lesson was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_topic
      @topic = Topic.find(params[:topic_id])
    end

    def set_lesson
      @lesson = Lesson.find(params[:id])
      @site_title = 'Lesson:: '+@lesson.title
    end

    def lesson_params
      params.require(:lesson).permit(:topic_id, :title, :description, :lesson_type, :tags, :language, :approval_status, :refnum, :instructor_id)
    end

    def lesson_update
      params.require(:lesson).permit(:title, :description, :lesson_type, :privacy, :tags, :language, :approval_status)
    end
end
