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
    @explanations = @lesson.explanations.order('id ASC')
    @explanations_json = @explanations.to_json
    @prior_expl = @lesson.explanations.find_by(position_prior: '1')
    @explanations && @prior_expl ? (@prior_expl.video_token ? @exp_prog = 3 : @exp_prog = 2 ) : (
      @explanations ? @exp_prog = 1 : @exp_prog = 0) 

    @prompt = Prompt.new
    @prompts = @lesson.prompts.order('id ASC')
    @prompts_json = @prompts.to_json
    @prior_prompt = @lesson.prompts.find_by(position_prior: '1')
    @prompts && @prior_prompt ? (@prior_prompt.video_token ? @prompt_prog = 3 : @prompt_prog = 2 ) : (
      @prompts ? @prompt_prog = 1 : @prompt_prog = 0) 

    @model = Model.new
    @models = @lesson.models.order('id ASC')
    @models_json = @models.to_json
    @prior_model = @lesson.models.find_by(position_prior: '1')
    @models && @prior_model ? (@prior_model.video_token ? @model_prog = 3 : @model_prog = 2 ) : (
      @models ? @model_prog = 1 : @model_prog = 0)

    @concept = Concept.new

    @rehearsal = Rehearsal.new
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
