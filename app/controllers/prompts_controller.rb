class PromptsController < ApplicationController
  def prompt_token
    prompt_token = token_params[:prompt]
    @lesson.prompt = prompt_token

    if @lesson.save!
      render json: @lesson.prompt, status: :ok
    end
  end
end
