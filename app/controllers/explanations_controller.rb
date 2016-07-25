class ExplanationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson, only: [:new]
  before_action :set_explanation, only: [:show, :index, :edit, :update, :destroy]

  def new
    @explanation = Explanation.new
  end

  def show
  end

  def edit
    @thislesson = Lesson.find(@explanation.lesson_id)
  end

  def create
    @lesson = current_user.lessons.find(params[:lesson_id])
    @lesson.explanations.build(explanation_params)

    respond_to do |format|
      if @lesson.save
        @explanation = Explanation.find(@lesson.explanations.last)
        format.html { redirect_to edit_explanation_path(@explanation), notice: 'Explanation has been saved' }
        format.json { render :show, status: :created, location: @explanation }
      else
        format.html { render :new }
        format.json { render json: @explanation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
   respond_to do |format|
      if @explanation.update(explanation_params)
        @explanation = Explanation.find(params[:id])
        @lesson = Lesson.find(@explanation.lesson_id)
        @topic = Topic.find(@lesson.topic_id)
        @course = Course.find(@topic.course_id)
        format.html { redirect_to course_topic_lesson_path(@course, @topic, @lesson), notice: 'Explanation was successfully created.' }
        format.json { render :show, status: :ok, location: @explanation }
      else
        format.html { render :edit }
        format.json { render json: @explanation.errors, status: :unprocessable_entity }
      end
   end
  end

  def destroy
    @explanation.destroy
    respond_to do |format|
      format.html { redirect_to explanations_url, notice: 'Explanation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_explanation
    @explanation = Explanation.find(params[:id])
  end

  def explanation_params
      params.require(:explanation).permit(:user_id, :lesson_id, :title, :script, :privacy, :language, :token, :video_token, :position_prior)
  end

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
end
