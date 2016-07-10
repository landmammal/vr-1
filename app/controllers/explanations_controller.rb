class ExplanationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson, only: [:new]
  def new
    @explanation = Explanation.new
  end

  def create
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

  def lesson_params
      params.require(:explanation).permit(:instructor_id, :lesson_id, :token, :video_token, :script)
  end

  def set_lesson
    @lesson = Lesson.find(params[:topic_id])
  end
end
