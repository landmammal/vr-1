class ExplanationsController < ApplicationController

  def new
    @explanation = Explanation.new
  end
  def show
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
end
