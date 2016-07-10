class ExplanationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson, only: [:new]

  def new
    @explanation = Explanation.new
  end

  def create
    @lesson = current_user.lessons.find(params[:lesson_id])
    @lesson.explanations.build(explanation_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @lesson, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def explanation_token
    explanation_token = token_params[:explanation]
    @lesson.explanation = explanation_token

    if @lesson.save!
      render json: @lesson.explanation, status: :ok
    end
  end

  private
  def set_explanation
    @explanation = Explanation.find(params[:id])
  end

  def explanation_params
      params.require(:explanation).permit(:instructor_id, :lesson_id, :token, :video_token, :script)
  end

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
end
