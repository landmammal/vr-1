class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:show, :new, :create]
  before_action :set_topic, only: [:show, :new]
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
    @explanations = @lesson.explanations.select(:id, :title, :position_prior, :privacy, :video_token).order('id ASC')
    @prior_expl = @lesson.explanations.find_by(position_prior: '1')

    @prompt = Prompt.new
    @prompts = @lesson.prompts.select(:id, :title, :position_prior, :privacy, :video_token).order('id ASC')
    @prior_prompt = @lesson.prompts.find_by(position_prior: '1')

    @model = Model.new
    @models = @lesson.models.select(:id, :title, :position_prior, :privacy, :video_token).order('id ASC')
    @prior_model = @lesson.models.find_by(position_prior: '1')
    

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

    if params[:title] = ''
      @topic.lessons.last.title = 'New Lesson (rename)'
    end

    respond_to do |format|
      if @topic.save
        @lesson = @topic.lessons.last
        format.html { redirect_to course_topic_lesson_path(@course, @topic, @lesson), notice: 'Lesson was successfully created.' }
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
    @topic = current_user.topics.find(params[:lesson][:topic_id])
    @course = @topic.courses.first

    respond_to do |format|
      if @lesson.update(lesson_update)
        format.html { redirect_to course_topic_lesson_path(@course, @topic, @lesson), notice: 'Lesson was updated created.' }
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
    # this is madness and a quick fix for deleting a topic
    # when this topic gets delete it all rehearsals associated with the topic are delete it.
    # this is madness .. this is sparta
      @topic = @lesson.topics.first
      @course = @topic.courses.first
      @lesson.rehearsals.delete_all
      @lesson.destroy
      respond_to do |format|
        format.html { redirect_to course_topic_path(@course, @topic), notice: 'Lesson was successfully destroyed.' }
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
      @site_title = 'Lesson:: '+@lesson.title
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:topic_id, :title, :description, :lesson_type, :tags, :approval_status, :instructor_id)
    end

    def lesson_update
      params.require(:lesson).permit(:topic_id, :title, :description, :lesson_type, :tags, :approval_status)
    end
end
