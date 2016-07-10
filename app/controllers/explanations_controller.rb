class ExplanationsController < ApplicationController
  def explanation_token
    explanation_token = token_params[:explanation]
    @lesson.explanation = explanation_token

    if @lesson.save!
      render json: @lesson.explanation, status: :ok
    end
  end
end
