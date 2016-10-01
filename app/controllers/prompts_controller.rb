class PromptsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson, only: [:new]
  before_action :set_prompt, only: [:show, :index, :edit, :update, :destroy]
  before_action :set_prompt_update, only: [:edit, :update, :destroy]

  def new
    @prompt = Prompt.new
  end

  def edit
    @thislesson = Lesson.find(@prompt.lesson_id)
  end

  def show
  end

  def create
    @lesson = current_user.lessons.find(params[:lesson_id])
    @lesson.prompts.build(prompt_params)

    respond_to do |format|
      if @lesson.save
        @prompt = Prompt.find(@lesson.prompts.last)
        format.html { redirect_to edit_prompt_path(@prompt) }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
   respond_to do |format|
      if @prompt.update(prompt_update)
        format.html { redirect_to  course_topic_lesson_path(@course, @topic, @lesson), notice: 'Prompt was successfully updated.' }
        format.json { render :show, status: :ok, location: @explanation }
      else
        format.html { render :edit }
        format.json { render json: @explanation.errors, status: :unprocessable_entity }
      end
   end
  end

  def destroy
    # this will be invalid if prompts can be sold to other users
    @prompt.lesson_prompts.delete_all
    @prompt.destroy
    respond_to do |format|
      format.html { redirect_to course_topic_lesson_path(@course, @topic, @lesson), notice: 'Prompt was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def set_prompt
    @prompt = Prompt.find(params[:id])
    @title = @course.title
  end

  def prompt_params
    params.require(:prompt).permit(:user_id, :lesson_id, :title, :script, :privacy, :language, :token, :video_token, :position_prior)
  end
  def prompt_update
    params.require(:prompt).permit(:lesson_id, :title, :script, :privacy, :language, :token, :video_token, :position_prior)
  end

  def set_prompt_update
    @prompt = Prompt.find(params[:id])
    @lesson = Lesson.find(@prompt.lesson_id)
    @topic = Topic.find(@lesson.topic_id)
    @course = Course.find(@topic.course_id)
  end
end
