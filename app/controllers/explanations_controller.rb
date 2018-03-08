class ExplanationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson, only: [:new]
  before_action :set_explanation, only: [:show, :edit, :update, :destroy]
  before_action :set_explanation_update, only: [:edit, :update, :destroy]

  def new
    # @newComponent = Explanation.new
    # @this_component = 'Explanation'
    # @this_error = 'error_explanation'
    # @this_added_class = 'explanation'
    # respond_to { |format| format.js { }}
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
        @newComponent = Explanation.find(@lesson.explanations.last)
        # format.html { redirect_to edit_explanation_path(@explanation), notice: 'Explanation has been saved' }
        # format.json { render :show, status: :created, location: @explanation }
        format.js { }
      else
        # format.html { render :new }
        # format.json { render json: @explanation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # @explanation.title = 'New Explanation (rename)' if params[:title] == '' || params[:title] == nil
   respond_to do |format|
      if @explanation.update(explanation_update)
        format.html { redirect_to course_topic_lesson_path(@course, @topic, @lesson), notice: 'Explanation was successfully updated.' }
        format.json { render :show, status: :ok, location: @explanation }
      else
        format.html { render :edit }
        format.json { render json: @explanation.errors, status: :unprocessable_entity }
      end
   end
  end

  def destroy
    # this will be and issue if explantions are been transfer to other users. but if not is valid way of deleting and explantion and its dependecies
    @explanation.lesson_explanations.destroy_all
    @explanation.destroy
    respond_to do |format|
      format.html { redirect_to course_topic_lesson_path(@course, @topic, @lesson), notice: 'Explanation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_explanation
    @explanation = Explanation.find(params[:id])
  end

  def explanation_params
      params.require(:explanation).permit(:user_id, :lesson_id, :title, :script, :privacy, :language, :video_type, :token, :video_token, :refnum, :position_prior)
  end

  def explanation_update
      params.require(:explanation).permit(:title, :script, :privacy, :language, :video_type, :token, :video_token, :position_prior)
  end

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def set_explanation_update
    @explanation = Explanation.find(params[:id])
    @lesson = Lesson.find(@explanation.lesson_id)
    @topic = Topic.find(@lesson.topic_id)
    @course = Course.find(@topic.course_id)
  end
end
